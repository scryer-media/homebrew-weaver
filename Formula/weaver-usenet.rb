class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.41"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.41/weaver-darwin-arm64.tar.gz"
      sha256 "a4ac7066ea27ce4e9eeaa626d6c011971546f855d2d90cd602b00a95575ba308"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.41/weaver-darwin-x86_64.tar.gz"
      sha256 "6ee7ea130a29406fdc1b55e5e84cbefa03ad6aa70a41f3d3a109a00181fd9694"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.41/weaver-linux-arm64.tar.gz"
      sha256 "f1e8f133bc4e3ffabfe60eb0352c2e140ba0d8508b54dee976d74312a7025297"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.41/weaver-linux-x86_64.tar.gz"
      sha256 "1572019068e4aa52506d4e5f54656509f27c1b41ad66ff3dbe67bde5b1aca90d"

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
