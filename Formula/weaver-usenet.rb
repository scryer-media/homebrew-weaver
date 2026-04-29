class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.2/weaver-darwin-arm64.tar.gz"
      sha256 "52045f3090d408f988b2c4802afe4c63101408a7c298bed30c54f6d541708551"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.2/weaver-darwin-x86_64.tar.gz"
      sha256 "8e83c663fb772d0d00dbf14e4aeef8a942d00ac83bd340fc05252bad439ac5b8"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.2/weaver-linux-arm64.tar.gz"
      sha256 "bdf2d42bd2863b431fd90dab84776924f29f603975ba80ca2180b3a87d06995e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.2/weaver-linux-x86_64.tar.gz"
      sha256 "1eab87168ffb297c3294615b48076f4f464471c2f0114e1d695aad4aeffb66e8"

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
