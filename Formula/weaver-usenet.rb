class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.1/weaver-darwin-arm64.tar.gz"
      sha256 "568587a13b445b3691413ff95c036be35a9d310a85b6a7205200b8763f861ea8"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.1/weaver-darwin-x86_64.tar.gz"
      sha256 "a8dad4f588b490a2e83eb6dcc5c48cf21ea63482a7409b14dd705865d7e9f684"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.1/weaver-linux-arm64.tar.gz"
      sha256 "afea8d98266811f3f643d5eb0e06f09a2f16983389972a6b6bf9c3b1a4515c5e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.1/weaver-linux-x86_64.tar.gz"
      sha256 "ca72cde1272fecda3b5b2f7de9b685403ab299cecb59476bfeef4eb6fb7ec972"

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
