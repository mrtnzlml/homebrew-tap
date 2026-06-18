class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.2.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "8eaf3685276957af8f2ae6907d9b4e3f7a017429fb0dcbefacd11f6ea3106e39"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "7d04903ca5d15126275d97534fc548a2dc328689c92167ad14ecdc550f089ad8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5911529fea5ef331516fcd4bea62f93cbb1ac7145703e85531f0710aa8fb6ca9"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
