class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.13"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.13/weaver-darwin-arm64.tar.gz"
      sha256 "51d259c044f5310fafe3e0ea1cafdf429b10b502ef4824210cde9665a34c85e7"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.13/weaver-darwin-x86_64.tar.gz"
      sha256 "83e7dc5076e3c9e4e457d7b09235dbda96b89492b1721c94270234ddefae9ab3"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.13/weaver-linux-arm64.tar.gz"
      sha256 "456abe39b170dd440f40a14151836372b83099d7cb419a8dffe3fa86e12936e9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.13/weaver-linux-x86_64.tar.gz"
      sha256 "76fa31886630bfcf69e356f9c0ac33de3582c880c62cc639a22e7af815836e21"

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
