class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.1.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "dad6d28beca129aa14698154c317b6b68817f473240f4a2d9e4c0d09ff28d4f7"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "f6eedf4b63271b3e19fba45abe26cb598f1f7c8f7797dbf3bcc5bd8f99e9d631"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "091e790f63f356dc2ef391cb42689c24b1ed197f08ade9459f96a04084d6209c"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
