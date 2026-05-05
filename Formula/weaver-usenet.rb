class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.10/weaver-darwin-arm64.tar.gz"
      sha256 "a94e10d2b7e1c0c89db7e0819fbb9ba2774662842f58e2863f3abf40e0ff4f69"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.10/weaver-darwin-x86_64.tar.gz"
      sha256 "2b2ddd8265b911e98424cd298dc7d5a6cf6cdf04e15ecbece43feb4384554272"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.10/weaver-linux-arm64.tar.gz"
      sha256 "32c2e2f186cc093c40655b014814b58338cee9d3032bd2258757a8eeaf582a77"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.10/weaver-linux-x86_64.tar.gz"
      sha256 "a9559235712edd65752bfec4440762063e887506b51e9c12e53039ccca439964"

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
