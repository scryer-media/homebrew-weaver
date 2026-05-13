class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.4.5"
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
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.5/weaver-darwin-arm64.tar.gz"
      sha256 "f4a38f4f1dcd3a90fe5f75933d8cad04145def87a53dbd1f919a98e8fbd5db46"

    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.5/weaver-darwin-x86_64.tar.gz"
      sha256 "3bf110fed2354d16b7ee82c3078e2d006f2dfb045e10b3eaba7371947ada3229"

    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.5/weaver-linux-arm64.tar.gz"
      sha256 "9fef1f69812516b25aeff2062be055f95be1bb1955fe1cc9b69c7a650f4824d7"

    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.5/weaver-linux-x86_64.tar.gz"
      sha256 "f7843cc4d09d50680c57028d7b0decfc436cf39ac5831290763d15011df27c7d"

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
