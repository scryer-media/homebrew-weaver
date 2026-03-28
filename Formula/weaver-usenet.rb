class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.51"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.51/weaver-darwin-arm64.tar.gz"
      sha256 "b377dcf341e42b63c3e0e9fcbb992f16128df035ba9e84bc9bf771245b893f1c"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.51/weaver-darwin-x86_64.tar.gz"
      sha256 "56677c240c34c58bbd88ab8ecbc49b3fd33209bbc84d8020de9767063762b684"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.51/weaver-linux-arm64.tar.gz"
      sha256 "212341868792e0630f6a155fa6cab7aca818c5844134543b04fcffd9184b1ff9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.51/weaver-linux-x86_64.tar.gz"
      sha256 "b81083ddff55a99d25cd743ba4e89319aa421812aec0afd3ee4dcb6300e328e6"

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
