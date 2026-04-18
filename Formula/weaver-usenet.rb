class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.3/weaver-darwin-arm64.tar.gz"
      sha256 "28a3f3441b82d94228cb0a53f2528b5d646ecba5024de18300952acb3d00740d"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.3/weaver-darwin-x86_64.tar.gz"
      sha256 "19471b9c08ebe4019623f8c96bb4dbc9015f7a5256739b97e3f736a52a5b63bb"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.3/weaver-linux-arm64.tar.gz"
      sha256 "47649cae21876b60873c4bf18eea200beee301feae0460523390d714d741d990"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.3/weaver-linux-x86_64.tar.gz"
      sha256 "c41f28b8e727f72c2517147da2a50db0b3d5b7b7a711421115ef7efd02c61b10"

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
