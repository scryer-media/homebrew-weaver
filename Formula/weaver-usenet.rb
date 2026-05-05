class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.11"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.11/weaver-darwin-arm64.tar.gz"
      sha256 "6a7fba50644c63ff6548ee1cf772853232f8be16384dbf9d66949e0a10086829"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.11/weaver-darwin-x86_64.tar.gz"
      sha256 "6851650f72450856ce4c505ef37f6ece1ebbc9de177bbf633c9c98a143fe7fd0"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.11/weaver-linux-arm64.tar.gz"
      sha256 "7481622dbec17d4dff79a17ab2ee71f7a3fbb6e508201fc103dec8455182e73a"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.11/weaver-linux-x86_64.tar.gz"
      sha256 "54f34325ea86c015a1d13b750f311153453e32b77a9a126677a537901dc26beb"

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
