class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.1/weaver-darwin-arm64.tar.gz"
      sha256 "6ffbb458e9144568906f12b9aff2cfabc1b2ffe744e199b445f0b6421462dedf"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.1/weaver-darwin-x86_64.tar.gz"
      sha256 "40e2249747433826f90a08e2081440c4ce69768eebebc60993c45ac450a20264"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.1/weaver-linux-arm64.tar.gz"
      sha256 "e076400a9172e245b0041ef1f3e188c16b4b9bbb51c859097c9f4d7d63062283"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.4.1/weaver-linux-x86_64.tar.gz"
      sha256 "ef8505eafbd06693086fc9c01ba2723cac5b28d3d19842a91fca4f17603f733c"

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
