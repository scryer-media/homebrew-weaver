class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.2/weaver-darwin-arm64.tar.gz"
      sha256 "b9c0a60876603a4a581b8fdcaf805f51bdf81276a4e60303b5c7951c2782f3bc"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.2/weaver-darwin-x86_64.tar.gz"
      sha256 "221561e7004f8ea510cf4c44909be657a939b145ae5197482fa943ed04b63a87"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.2/weaver-linux-arm64.tar.gz"
      sha256 "38e850cd754586e1232649659ab371a386bd686f877916550d06c30ced75e9c1"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.2/weaver-linux-x86_64.tar.gz"
      sha256 "242170f478d9097385b1229b1c44aa93fae715241d012998e3ae46d0c0fc6865"

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
