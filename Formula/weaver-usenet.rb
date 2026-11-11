require "rbconfig"

module WeaverUsenetReleaseSelection
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

  def self.asset_name(os:, arch:)
    case [os, arch]
    when ["linux", "x86_64"] then "weaver-linux-x86_64-portable.tar.gz"
    when ["linux", "arm64"] then "weaver-linux-arm64-portable.tar.gz"
    when ["macos", "x86_64"] then "weaver-darwin-x86_64-portable.tar.gz"
    when ["macos", "arm64"] then "weaver-darwin-arm64-portable.tar.gz"
    else
      raise "unsupported asset mapping: #{[os, arch].inspect}"
    end
  end

  def self.asset_url(repo:, version:, os:, arch:)
    "https://github.com/#{repo}/releases/download/weaver-v#{version}/#{asset_name(os: os, arch: arch)}"
  end

  def self.asset_sha256(os:, arch:, checksums:)
    checksums.fetch(asset_name(os: os, arch: arch))
  end

end

class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.16.13"
  license "MIT"
  RELEASE_REPO = "scryer-media/weaver"
  RELEASE_VERSION = "0.16.13"
  CHECKSUMS = {
    "weaver-linux-x86_64-portable.tar.gz" => "5aee68f32e688d357f0235793f10949f19c3f4f3d26524faa63eec897c4aab48",
    "weaver-linux-arm64-portable.tar.gz" => "b3ad8ab79452e90bc2e1567bb1526223a417db46ad9d2ebea38fd2133f553387",
    "weaver-darwin-x86_64-portable.tar.gz" => "cd5b6f1484ce9195b174c44fb79de22b5a05096888e7e92af57c93f0665068a0",
    "weaver-darwin-arm64-portable.tar.gz" => "db7ab81b3b53d2b5f0cfe399976dcbe2078ff247b2a9a059f4ddb53b850af356",
  }.freeze
  SELECTED_OS = WeaverUsenetReleaseSelection.current_os
  SELECTED_ARCH = WeaverUsenetReleaseSelection.current_arch

  url WeaverUsenetReleaseSelection.asset_url(
    repo: RELEASE_REPO,
    version: RELEASE_VERSION,
    os: SELECTED_OS,
    arch: SELECTED_ARCH,
  )
  sha256 WeaverUsenetReleaseSelection.asset_sha256(
    os: SELECTED_OS,
    arch: SELECTED_ARCH,
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
