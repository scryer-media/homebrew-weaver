class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.43"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-darwin-arm64.tar.gz"
      sha256 "887e289320b9bc1c03c3bc326407cf5eaeed90bcdc9e90ba31bb532531b8c295"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-darwin-x86_64.tar.gz"
      sha256 "c317327132dc0c4aa7f259a5071c9b0de5afe6992e2d41aeb46e4364ccea03cb"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-linux-arm64.tar.gz"
      sha256 "48280749d3e3cdc95a5d37926ffdd974c6c1152955d8f63f910bfcaeef9c398e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-linux-x86_64.tar.gz"
      sha256 "2ea791648567d2d91132a185aad09a089b9d77ba9bb2cc0e9fd68e52ea33cc82"

      def install
        bin.install "weaver"
      end
    end
  end

  service do
    run [opt_bin/"weaver", "--config", var/"weaver", "serve"]
    keep_alive true
    log_path var/"log/weaver.log"
    error_log_path var/"log/weaver.log"
  end

  test do
    assert_match "weaver", shell_output("#{bin}/weaver --version")
  end
end
