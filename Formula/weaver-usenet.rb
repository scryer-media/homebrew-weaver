class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.5/weaver-darwin-arm64.tar.gz"
      sha256 "bcf9505fb864317028fc25c81f11fea26425b0277c472acfb1355b8bb7152817"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.5/weaver-darwin-x86_64.tar.gz"
      sha256 "b2d433484fa95d48c6f9c2b30821a43d74e2a6e316351dee77b8b5f315a43158"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.5/weaver-linux-arm64.tar.gz"
      sha256 "12596bf2a3d003a37a43856d6c33481a050e450ff7b962b63dc697ced59bcc25"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.5/weaver-linux-x86_64.tar.gz"
      sha256 "2946ee76e4546728b2faf209d6b066ea90abf07e8b08143b84c063a1615196d2"

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
