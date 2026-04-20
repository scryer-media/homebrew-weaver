class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.8/weaver-darwin-arm64.tar.gz"
      sha256 "f2dd52dc1f64721189b1f4976238842aa248d3ce116033cc328679d1397fbd0e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.8/weaver-darwin-x86_64.tar.gz"
      sha256 "c729c4dffb6343fa1d69a57ab1980189b4c0e8dba1712176af8f5b81d5c6d405"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.8/weaver-linux-arm64.tar.gz"
      sha256 "d52b277928ab87a90e60861588dc4b239984aa44eea837c1598fa68f6cf97a16"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.8/weaver-linux-x86_64.tar.gz"
      sha256 "93634be433ef8dce2251a7b52f849b5d5bfd45ba97a75090f560e6bb3b894f2d"

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
