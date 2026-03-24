class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.43"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-darwin-arm64.tar.gz"
      sha256 "4d22f5d53a1d72705a6576e2a41e24bb3010d81fe5371ad03e11630f5cdd97e9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-darwin-x86_64.tar.gz"
      sha256 "b1d350dc2895b6874106b27b1dccd85a9ccec812c4acfe1dd7d95482e590facd"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-linux-arm64.tar.gz"
      sha256 "a21a28d72d758a593986d7398a9983ddf2dcc6397ec29ec3296857c993e3eb23"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.43/weaver-linux-x86_64.tar.gz"
      sha256 "e90956c73f37448b1816cf7751cd552b33aba1a792648346183fb9bdcce2cfa4"

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
