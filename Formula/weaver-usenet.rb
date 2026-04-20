class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.7/weaver-darwin-arm64.tar.gz"
      sha256 "238c48b168798e182bb86930a316b847707eb326d7bccc3dc4f654d4aebe4a61"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.7/weaver-darwin-x86_64.tar.gz"
      sha256 "5c5d7dc5c408c00b65ff9b93f17aa01e39f7e90e9f5e9ac36eeee590f9b395dd"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.7/weaver-linux-arm64.tar.gz"
      sha256 "a189cbdb5e6d647963c044fda896894160ce9056aca4b9fca013bc45f17357ce"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.7/weaver-linux-x86_64.tar.gz"
      sha256 "62709b6a84c05d6e1c74750b4bf13ed2f78a2b124fa7da01a118a1bb4f675328"

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
