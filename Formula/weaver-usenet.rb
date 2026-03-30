class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.0/weaver-darwin-arm64.tar.gz"
      sha256 "d45168667ac1744f439f9952da27d0e1b55d8011e09af0d77dd08c28bfdcd22d"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.0/weaver-darwin-x86_64.tar.gz"
      sha256 "1e1b3e8844e86540476dce8f44229176ea3ae1464b708b349172b3ed71c25f17"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.0/weaver-linux-arm64.tar.gz"
      sha256 "523f4d3a66a918feacfd2dd9a9e482d5083461f45b476ee873401ea800acccbd"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.2.0/weaver-linux-x86_64.tar.gz"
      sha256 "51d0c78414e9c0aa8e1c94ba536dbb668c50e439d6a5819cebf1fb4b4eb0c04e"

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
