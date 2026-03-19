class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.35"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.35/weaver-darwin-arm64.tar.gz"
      sha256 "4b43555627f77151db5e7adcb5f6d5512971032c567af6c3b855ac63088c99df"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.35/weaver-darwin-x86_64.tar.gz"
      sha256 "0c9c7b109ce70397a46c5379e6c96b67840f1a1fdeccbaa2e1b8b110dd63c36c"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.35/weaver-linux-arm64.tar.gz"
      sha256 "b08e22f43076b8fc53966c35f9ab161381d6135aff82a82022c68b3f43a14416"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.35/weaver-linux-x86_64.tar.gz"
      sha256 "ef02021b246ba4343d251d13af30b742ef31ef63a2ab17de7cac66531df0f9ef"

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
