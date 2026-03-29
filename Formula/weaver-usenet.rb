class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.52"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.52/weaver-darwin-arm64.tar.gz"
      sha256 "a3c35ee992f44b72313ece2b636af7c9b3173dcfa2e25b249934409cb381a222"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.52/weaver-darwin-x86_64.tar.gz"
      sha256 "ef0a1f9f2f40d089949cbfeb303854e7c8f7d42a6cb2b3752cf24752fe2b5e75"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.52/weaver-linux-arm64.tar.gz"
      sha256 "49de44148370907570b69309d7c98a816b1a7524c5110a0f8f9dbe567abf9361"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.52/weaver-linux-x86_64.tar.gz"
      sha256 "9a968be9b329ef2c75e3c43a67264624e9539f57a384c1ea062194f3f954dfb1"

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
