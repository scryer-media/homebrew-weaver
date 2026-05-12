class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-darwin-arm64.tar.gz"
      sha256 "7c6cc5a052d16656f5918e771ccd261c0dbaba8a2651838ea83418a4631bab1c"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-darwin-x86_64.tar.gz"
      sha256 "62083fcbacde818fee9a805515d9bfe632306bf42ed8f62888965e66103a30d1"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-linux-arm64.tar.gz"
      sha256 "064601f85fea8b3c2edd91c2ecc58fb3eb471c2217971ebe660c00678553197d"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.2/weaver-linux-x86_64.tar.gz"
      sha256 "a36bd5888c2cb0bbe2533b7c1f6e20fa32300891a0dea1ed29a8e80f5971aa3d"

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
