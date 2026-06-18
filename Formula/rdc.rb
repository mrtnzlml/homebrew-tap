class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.3.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "960d0983b811d64544afce2c01f2893ce58995613fdb4363f64c27ba15dbe91c"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "c1ceacc3b508b6a17102c51c280707eb7c18f74bafd4b8ec8aa4e5201a6b9b04"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "811fd0c964abccbf60ba193eb791aeb67588f347ddcfc4eb8a05d85293a1a0da"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
