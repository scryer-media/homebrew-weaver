class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.39"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.39/weaver-darwin-arm64.tar.gz"
      sha256 "d08f42b4d01027a2106d17f7915bc491eed5ec238afbce8fccb8dd649fcb4c8f"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.39/weaver-darwin-x86_64.tar.gz"
      sha256 "d7932ba497e6412b8e9be16d154cbeb388151271c5caeaedf1f7b7b56dc40585"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.39/weaver-linux-arm64.tar.gz"
      sha256 "b8f500c678bcda6f478a8e4a88502fb77aff3f18081f5c1f3272d7751bef6c0b"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.39/weaver-linux-x86_64.tar.gz"
      sha256 "a67d5b5a7d894105365ccd87ae6220fac2bf6d3c30d4b90024a7a0457bb09ef7"

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
