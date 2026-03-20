class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.40"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.40/weaver-darwin-arm64.tar.gz"
      sha256 "60aa32e9743f7e1e4249604e07b9b43ea7a675c4cd65e652807b922e1894dc25"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.40/weaver-darwin-x86_64.tar.gz"
      sha256 "cfa5e0d012414d0f1a0e2674f7b189210a1e4b2b7f8794b298b436f4a8cc46fd"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.40/weaver-linux-arm64.tar.gz"
      sha256 "8a98b4fa65cd27ac15fbd7ca73690588cd1964187d9aaa25ec101c774619edd9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.40/weaver-linux-x86_64.tar.gz"
      sha256 "f8a9b4915ab9c2c2006e958b81e8401da53db47ba9c6c79af12bc0cdc1e3bff0"

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
