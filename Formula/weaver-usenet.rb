class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.4.6"
  license "MIT"

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

      if [ -f "" ]; then
        set -a
        . ""
        set +a
      fi

      : "#{var/weaver}"
      : "9090"
      : "/"

      exec "#{opt_bin}/weaver" --config "#{var" serve --port "9090" --base-url "/" ""
    SH

    chmod 0755, libexec/"weaver-service"
  end

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.6/weaver-darwin-arm64.tar.gz"
      sha256 "b36311a0a57c29eaa3ae4b63c71456fca65aad04919577318de3b3a6094bf9d2"

    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.6/weaver-darwin-x86_64.tar.gz"
      sha256 "ca832e7980b7558e12d9683df679248e26a2d741ba29d2cf42d7c0b012ee3c54"

    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.6/weaver-linux-arm64.tar.gz"
      sha256 "e9ffb07d3243e69d0a2cc3c4598df4deb060c6e69d61febc9ff39808ba615357"

    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.6/weaver-linux-x86_64.tar.gz"
      sha256 "1b9dc743a3391c3058bd64a3c5f98956eb3e0afd09da71f250961f73877671d2"

    end
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
