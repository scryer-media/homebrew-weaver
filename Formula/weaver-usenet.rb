require "open3"
require "rbconfig"
require "set"

module WeaverUsenetReleaseSelection
  X86_HASWELL_FEATURES = %w[
    avx
    avx2
    bmi1
    bmi2
    f16c
    fma
    lzcnt
    movbe
    pclmulqdq
    popcnt
    rdrand
    sse3
    sse4.1
    sse4.2
    ssse3
    xsave
    xsaveopt
  ].freeze

  LINUX_ARM64_CORTEX_A76_FEATURES = %w[
    aes
    crc32
    dotprod
    fp16
    lse
    neon
    rdm
    sha2
  ].freeze

  MACOS_ARM64_APPLE_M1_FEATURES = %w[
    aes
    dotprod
    fp16
    lse
    neon
    sha2
  ].freeze

  def self.current_os
    host_os = RbConfig::CONFIG["host_os"].to_s.downcase
    return "macos" if host_os.include?("darwin")
    return "linux" if host_os.include?("linux")

    "unknown"
  end

  def self.current_arch
    host_cpu = RbConfig::CONFIG["host_cpu"].to_s.downcase
    return "arm64" if host_cpu.include?("aarch64") || host_cpu.include?("arm64")
    return "x86_64" if host_cpu.include?("x86_64") || host_cpu.include?("amd64")

    "unknown"
  end

  def self.current_lane
    detect_lane(
      os: current_os,
      arch: current_arch,
      linux_cpuinfo: current_os == "linux" ? read_linux_cpuinfo : nil,
      sysctl_values: current_os == "macos" ? read_macos_sysctl_values(current_arch) : {},
    )
  end

  def self.detect_lane(os:, arch:, linux_cpuinfo: nil, sysctl_values: {})
    case [os, arch]
    when ["macos", "x86_64"]
      normalized = normalize_x86_features(
        sysctl_feature_tokens(
sysctl_values["machdep.cpu.features"],
sysctl_values["machdep.cpu.leaf7_features"],
        ),
      )
      normalized.superset?(X86_HASWELL_FEATURES.to_set) ? "haswell" : "portable"
    when ["linux", "x86_64"]
      normalized = normalize_x86_features(cpuinfo_feature_tokens(linux_cpuinfo))
      normalized.superset?(X86_HASWELL_FEATURES.to_set) ? "haswell" : "portable"
    when ["macos", "arm64"]
      required = {
        "aes" => "hw.optional.arm.FEAT_AES",
        "dotprod" => "hw.optional.arm.FEAT_DotProd",
        "fp16" => "hw.optional.arm.FEAT_FP16",
        "lse" => "hw.optional.arm.FEAT_LSE",
        "neon" => "hw.optional.arm.AdvSIMD",
        "sha2" => "hw.optional.arm.FEAT_SHA256",
      }
      present = required.all? do |_feature, key|
        truthy_sysctl?(sysctl_values[key])
      end
      present ? "apple-m1" : "portable"
    when ["linux", "arm64"]
      normalized = normalize_linux_arm64_features(cpuinfo_feature_tokens(linux_cpuinfo))
      normalized.superset?(LINUX_ARM64_CORTEX_A76_FEATURES.to_set) ? "cortex-a76" : "portable"
    else
      "portable"
    end
  end

  def self.asset_name(os:, arch:, lane:)
    case [os, arch, lane]
    when ["linux", "x86_64", "portable"] then "weaver-linux-x86_64-portable.tar.gz"
    when ["linux", "x86_64", "haswell"] then "weaver-linux-x86_64-haswell.tar.gz"
    when ["linux", "arm64", "portable"] then "weaver-linux-arm64-portable.tar.gz"
    when ["linux", "arm64", "cortex-a76"] then "weaver-linux-arm64-cortex-a76.tar.gz"
    when ["macos", "x86_64", "portable"] then "weaver-darwin-x86_64-portable.tar.gz"
    when ["macos", "x86_64", "haswell"] then "weaver-darwin-x86_64-haswell.tar.gz"
    when ["macos", "arm64", "portable"] then "weaver-darwin-arm64-portable.tar.gz"
    when ["macos", "arm64", "apple-m1"] then "weaver-darwin-arm64-apple-m1.tar.gz"
    else
      raise "unsupported asset mapping: #{[os, arch, lane].inspect}"
    end
  end

  def self.asset_url(repo:, version:, os:, arch:, lane:)
    "https://github.com/#{repo}/releases/download/weaver-v#{version}/#{asset_name(os: os, arch: arch, lane: lane)}"
  end

  def self.asset_sha256(os:, arch:, lane:, checksums:)
    checksums.fetch(asset_name(os: os, arch: arch, lane: lane))
  end

  def self.read_linux_cpuinfo
    File.read("/proc/cpuinfo")
  rescue StandardError
    nil
  end

  def self.read_macos_sysctl_values(arch)
    values = {}
    if arch == "x86_64"
      %w[
        machdep.cpu.features
        machdep.cpu.leaf7_features
      ].each do |key|
        values[key] = read_sysctl(key)
      end
    elsif arch == "arm64"
      %w[
        hw.optional.arm.FEAT_AES
        hw.optional.arm.FEAT_DotProd
        hw.optional.arm.FEAT_FP16
        hw.optional.arm.FEAT_LSE
        hw.optional.arm.AdvSIMD
        hw.optional.arm.FEAT_SHA256
      ].each do |key|
        values[key] = read_sysctl(key)
      end
    end
    values
  end

  def self.read_sysctl(name)
    output, status = Open3.capture2("sysctl", "-n", name)
    status.success? ? output.strip : nil
  rescue StandardError
    nil
  end

  def self.cpuinfo_feature_tokens(cpuinfo_text)
    return [] if cpuinfo_text.to_s.empty?

    cpuinfo_text.each_line.filter_map do |line|
      match = line.match(/^\s*(flags|Features)\s*:\s*(.+)$/i)
      next unless match

      match[2].split(/\s+/)
    end.flatten
  end

  def self.sysctl_feature_tokens(*values)
    values.compact.flat_map { |value| value.split(/\s+/) }
  end

  def self.normalize_x86_features(tokens)
    tokens.each_with_object(Set.new) do |token, features|
      normalized = normalize_x86_feature(token)
      features << normalized if normalized
    end
  end

  def self.normalize_linux_arm64_features(tokens)
    tokens.each_with_object(Set.new) do |token, features|
      normalized = normalize_linux_arm64_feature(token)
      features << normalized if normalized
    end
  end

  def self.normalize_x86_feature(token)
    case token.to_s.downcase
    when "avx", "avx1.0" then "avx"
    when "avx2", "avx2.0" then "avx2"
    when "bmi1" then "bmi1"
    when "bmi2" then "bmi2"
    when "f16c" then "f16c"
    when "fma" then "fma"
    when "abm", "lzcnt" then "lzcnt"
    when "movbe" then "movbe"
    when "pclmul", "pclmulqdq" then "pclmulqdq"
    when "popcnt" then "popcnt"
    when "rdrand" then "rdrand"
    when "sse3" then "sse3"
    when "sse4_1", "sse4.1" then "sse4.1"
    when "sse4_2", "sse4.2" then "sse4.2"
    when "ssse3" then "ssse3"
    when "osxsave", "xsave" then "xsave"
    when "xsaveopt" then "xsaveopt"
    end
  end

  def self.normalize_linux_arm64_feature(token)
    case token.to_s.downcase
    when "aes" then "aes"
    when "crc", "crc32" then "crc32"
    when "asimddp", "dotprod" then "dotprod"
    when "fphp", "asimdhp", "fp16" then "fp16"
    when "atomics", "lse" then "lse"
    when "asimd", "neon" then "neon"
    when "asimdrdm", "rdm" then "rdm"
    when "sha2" then "sha2"
    end
  end

  def self.truthy_sysctl?(value)
    value.to_s.strip == "1"
  end
end

class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.6.3"
  license "MIT"
  RELEASE_REPO = "scryer-media/weaver"
  RELEASE_VERSION = "0.6.3"
  CHECKSUMS = {
    "weaver-linux-x86_64-portable.tar.gz" => "728aef24c1e3a7431c184b0cf36d906696408547415077c859f6436b4e55adc5",
    "weaver-linux-x86_64-haswell.tar.gz" => "001637f859cc3de9a9f440cb73266b2b1fee57cf812e40a11a64c1cd8c930189",
    "weaver-linux-arm64-portable.tar.gz" => "3b5f9fb99f2155ab15599c7a49d3e72013e0be9133abe9ac377ace535ea89cd9",
    "weaver-linux-arm64-cortex-a76.tar.gz" => "80f3159ee255389601b8bd0d3ed499d0becfd6d19fe3c5363387af275e7acd2b",
    "weaver-darwin-x86_64-portable.tar.gz" => "4c4a62df655a5371e34e0b177038c77c51643fbdf7e75158cf0746cdc47cdfcb",
    "weaver-darwin-x86_64-haswell.tar.gz" => "98c76b354f5ca70f68698efd88676e79cf7d6888c1757e245e6edd590769b512",
    "weaver-darwin-arm64-portable.tar.gz" => "57ab34662ad6e77943720cea2ceca2350a249c1c7ecabda280ecaf301f6ed31c",
    "weaver-darwin-arm64-apple-m1.tar.gz" => "3d5ca0549aa29006eeffcd811e96afaab6065c2f16ba469b756fd7d5d39aff05",
  }.freeze
  SELECTED_OS = WeaverUsenetReleaseSelection.current_os
  SELECTED_ARCH = WeaverUsenetReleaseSelection.current_arch
  SELECTED_LANE = WeaverUsenetReleaseSelection.current_lane

  url WeaverUsenetReleaseSelection.asset_url(
    repo: RELEASE_REPO,
    version: RELEASE_VERSION,
    os: SELECTED_OS,
    arch: SELECTED_ARCH,
    lane: SELECTED_LANE,
  )
  sha256 WeaverUsenetReleaseSelection.asset_sha256(
    os: SELECTED_OS,
    arch: SELECTED_ARCH,
    lane: SELECTED_LANE,
    checksums: CHECKSUMS,
  )

  def install_support_files
    (pkgshare/"config.env.example").write <<~EOS
      # Homebrew-managed Weaver service overrides.
      WEAVER_CONFIG=#{var}/weaver
      WEAVER_PORT=9090
      WEAVER_BASE_URL=/
    EOS

    (libexec/"weaver-service").write <<~SH
      #!/bin/sh
      CONFIG_FILE="#{etc}/weaver/config.env"

      if [ -f "$CONFIG_FILE" ]; then
        set -a
        . "$CONFIG_FILE"
        set +a
      fi

      : "${WEAVER_CONFIG:=#{var}/weaver}"
      : "${WEAVER_PORT:=9090}"
      : "${WEAVER_BASE_URL:=/}"

      exec "#{opt_bin}/weaver" --config "$WEAVER_CONFIG" serve --port "$WEAVER_PORT" --base-url "$WEAVER_BASE_URL" "$@"
    SH

    chmod 0755, libexec/"weaver-service"
  end

  def install
    bin.install "weaver"
    install_support_files

    config_dir = etc/"weaver"
    config_dir.mkpath
    config_file = config_dir/"config.env"
    unless config_file.exist?
      config_file.write <<~EOS
        WEAVER_CONFIG=#{var}/weaver
        WEAVER_PORT=9090
        WEAVER_BASE_URL=/
      EOS
    end
  end

  def caveats
    <<~EOS
      Edit #{etc}/weaver/config.env to customize the Homebrew-managed service,
      then restart it with:
        brew services restart weaver-usenet
    EOS
  end

  service do
    run [opt_libexec/"weaver-service"]
    keep_alive true
    log_path var/"log/weaver.log"
    error_log_path var/"log/weaver.log"
  end

  test do
    assert_match "weaver", shell_output("#{bin}/weaver --version")
  end
end
