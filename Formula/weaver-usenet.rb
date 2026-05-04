class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.7/weaver-darwin-arm64.tar.gz"
      sha256 "5734f3b7e23bcfb04ff64bdfc920f08ec92923f3e97c6ec62cf6e295c0769e76"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.7/weaver-darwin-x86_64.tar.gz"
      sha256 "8bb779d6d911f28abe9a8ccd4af7773f14f0d3a11393e9e4b93f215d199794d5"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.7/weaver-linux-arm64.tar.gz"
      sha256 "217c8287b6adf54e3107630ab16128ebecc912dbb9f5255f1c0932bc409543a7"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.7/weaver-linux-x86_64.tar.gz"
      sha256 "a39406505b02304328a54c68eb9a2635839314e0f91140087b13e2616060fd6d"

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
