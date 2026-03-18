class Weaver < Formula
  desc "Unified Usenet binary downloader, repair, and extraction engine"
  homepage "https://github.com/scryer-media/weaver"
  version "0.1.29"
  license "MIT"

  on_linux do
    on_arm do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.29/weaver-linux-arm64.tar.gz"
      sha256 "a81a1dff580730ff5d8462d61aeda319293a7db20d1f8423546a00f767fa8f96"
    end

    on_intel do
      url "https://github.com/scryer-media/weaver/releases/download/weaver-v0.1.29/weaver-linux-x86_64.tar.gz"
      sha256 "8d72bf940bb373d8d88fde6484df0838ca74ce2c184ccca626c77229ac88f480"
    end
  end

  def install
    bin.install "weaver"
  end

  test do
    assert_match "weaver", shell_output("#{bin}/weaver --version")
  end
end
