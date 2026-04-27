class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.0/weaver-darwin-arm64.tar.gz"
      sha256 "74db44c322e74a66945166b9fe2c0a97c15bb9430d8fec3aa843ff68ffdbe06e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.0/weaver-darwin-x86_64.tar.gz"
      sha256 "6168e42269afbe98438665a358a1003820067db0ddce561d629096d8ac6a566f"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.0/weaver-linux-arm64.tar.gz"
      sha256 "74cb15e164fed7bdf1e6008ababfbc4463929a7642ae1d1a0f6ebadad119fee9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.0/weaver-linux-x86_64.tar.gz"
      sha256 "b918f42cf9bba36cd55e016462bfe186330517dfef6225df6bd78f9c704a6f67"

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
