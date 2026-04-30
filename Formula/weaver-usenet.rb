class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.3/weaver-darwin-arm64.tar.gz"
      sha256 "b2316151c9df29a6e1e9b411c2872bd32d749fa4aa91fc146005533ba524e232"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.3/weaver-darwin-x86_64.tar.gz"
      sha256 "7a1f9936528b826cfedd8f673875144cb6788b6c8d071fa4c0495fb54cf2d6a1"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.3/weaver-linux-arm64.tar.gz"
      sha256 "1c4993182026ffd103d8601e8aaad894d99085dac09ed69360f635024815854e"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.3/weaver-linux-x86_64.tar.gz"
      sha256 "15df2e67795ff7e5f9a10d0c041e516b0288139717fe03b716edd4c2e5c9ef51"

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
