class WeaverUsenet < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.32"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.32/weaver-darwin-arm64.tar.gz"
      sha256 "a46630f96929b4ded170d5048bb7f84e55782b6eaccee7c60595734479f0adc1"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.32/weaver-darwin-x86_64.tar.gz"
      sha256 "0a3b7fed0ee8320fabf3ae553ed1f502382c6fe4b1f80cf1baf4de5c8ad45cbd"

      def install
        bin.install "weaver"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.32/weaver-linux-arm64.tar.gz"
      sha256 "0e704c8e5fa9ad6a20985cce59d7e53c038f03e3644f78f0a894f8bbc0bad933"

      def install
        bin.install "weaver"
      end
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.32/weaver-linux-x86_64.tar.gz"
      sha256 "d6ac553ca3398d5272f5293311db9f0bd7bc0e6ab6152d164bfc8eb03289f93b"

      def install
        bin.install "weaver"
      end
    end
  end

  test do
    assert_match "weaver", shell_output("#{bin}/weaver --version")
  end
end
