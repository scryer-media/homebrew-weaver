class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.4.2"
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

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-darwin-arm64.tar.gz"
      sha256 "7c6cc5a052d16656f5918e771ccd261c0dbaba8a2651838ea83418a4631bab1c"
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-darwin-x86_64.tar.gz"
      sha256 "62083fcbacde818fee9a805515d9bfe632306bf42ed8f62888965e66103a30d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-linux-arm64.tar.gz"
      sha256 "064601f85fea8b3c2edd91c2ecc58fb3eb471c2217971ebe660c00678553197d"
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-linux-x86_64.tar.gz"
      sha256 "a36bd5888c2cb0bbe2533b7c1f6e20fa32300891a0dea1ed29a8e80f5971aa3d"
    end
  end

  def install
    bin.install "weaver"
    install_support_files

    config_dir = etc/"weaver"
    config_dir.mkpath
    config_file = config_dir/"config.env"
    return if config_file.exist?

    config_file.write <<~EOS
      WEAVER_CONFIG=#{var}/weaver
      WEAVER_PORT=9090
      WEAVER_BASE_URL=/
    EOS
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
