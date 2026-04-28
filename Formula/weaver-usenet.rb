class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.1/weaver-darwin-arm64.tar.gz"
      sha256 "b9e9e3166b78d9b8f3740bf113371aa80d1078831edbda53ada0fbd461dd7574"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.1/weaver-darwin-x86_64.tar.gz"
      sha256 "6226b549b859c5c33c2ab4ead1766c56a2711ef87f6cda962a2242b595e85e26"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.1/weaver-linux-arm64.tar.gz"
      sha256 "a9ebac5599966ded89a4af11c25f1d8e77a70f520b5a91e3f065f1eb19c44e03"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.3.1/weaver-linux-x86_64.tar.gz"
      sha256 "2ea52b8e2e7c71f5e662f30376a225bfdaa81409a38b0d69ee40e56dea078750"

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
