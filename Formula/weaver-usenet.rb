class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.49"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.49/weaver-darwin-arm64.tar.gz"
      sha256 "13377042f4b59f2e0bf03eb828ffe1b7b6edadcb5be56debe13c4e486e928ccb"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.49/weaver-darwin-x86_64.tar.gz"
      sha256 "f4e43e1cea6a6eae77d49fd68a2b94489d38ef88470ee87465f01cdbad15f42e"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.49/weaver-linux-arm64.tar.gz"
      sha256 "8bea55343ca99fca19b25395625337c150e3b97ec27d6c9044e524fbe0147146"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.49/weaver-linux-x86_64.tar.gz"
      sha256 "fcf652d3d8be2b3ee60d355af93da7b104ea5006d1b5ca0cde914f89dec9dce6"

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
