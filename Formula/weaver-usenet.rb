class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.42"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.42/weaver-darwin-arm64.tar.gz"
      sha256 "b24b6ec90298ad630275a44e38bf22bf5fa804067382b1188b4b93469c74dd6e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.42/weaver-darwin-x86_64.tar.gz"
      sha256 "f9682928aaa65d3fa4cc775d07478b59fa8e2e78011e7e65ed6df5194340d744"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.42/weaver-linux-arm64.tar.gz"
      sha256 "d308acb40322432f534d0668429b9149c8d3889c6d966ce445d07840efc73ff3"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.42/weaver-linux-x86_64.tar.gz"
      sha256 "793399b3c0707cf5c959ce2b399547c129cbe62a4a8554b0b512ac1cdcfa0f1f"

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
