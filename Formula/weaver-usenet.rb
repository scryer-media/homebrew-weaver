class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.50"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.50/weaver-darwin-arm64.tar.gz"
      sha256 "044f112793875713b35edf355e514fb7460f9885a9afd2b7d9c829bd3180fa6b"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.50/weaver-darwin-x86_64.tar.gz"
      sha256 "fee939012f0eee41ff4483a1bf419709b200fa3b3be5458dac85b87db5fd4077"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.50/weaver-linux-arm64.tar.gz"
      sha256 "a14424cd69167deefad4e7bf9d3d39328168b12ee9aa8cfafd1b9b92a9374fdc"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.50/weaver-linux-x86_64.tar.gz"
      sha256 "2b2f86a88c541cfc58028c16d310ab2beb3231ea418bd1c3f631a524432fcf16"

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
