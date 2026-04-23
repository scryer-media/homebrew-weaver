class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.9/weaver-darwin-arm64.tar.gz"
      sha256 "a0dd40f7a79b9926390ee3c5e85ba9742566dbc15f0563ab28796c7fb53435c8"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.9/weaver-darwin-x86_64.tar.gz"
      sha256 "c821c6b4f4e3d7a58636c70f7fcaa3e664e4c4f0f1f1b92e828da6634ff16a42"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.9/weaver-linux-arm64.tar.gz"
      sha256 "69d6bd43af2368be3f296f89c55a895d623c190d40cfe6a034d29348b1a558a9"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.9/weaver-linux-x86_64.tar.gz"
      sha256 "ca67cc3729031047a72cb93f89ae2b5674ae70ce8147f36ab4101fca4b5c3d4d"

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
