class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.45"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.45/weaver-darwin-arm64.tar.gz"
      sha256 "36f3e7dc75e2c03acdc97eb55fa5f47b84a276c35043c3cc1ed6d3c69cab6a29"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.45/weaver-darwin-x86_64.tar.gz"
      sha256 "447fe074dce6f82e503ab5705f5f6a071cbda96ff7c3bc6de5491b9e3d755863"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.45/weaver-linux-arm64.tar.gz"
      sha256 "91221fbf6839492bc4d494af523020fa164cc8ca06abfa1d2b65b96a72f88b02"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.45/weaver-linux-x86_64.tar.gz"
      sha256 "9b5c7f8dd70f5f8a612705a9ff99ff5b6ed829f7172feb27703e561ba188476d"

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
