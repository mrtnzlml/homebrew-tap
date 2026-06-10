class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.3.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "8851037f437f81c27b2eacec11337d34723dc58c2d7e5b16d91c8547dac117fa"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "3ee22ce5ee491b5b15eade16074a19426cdb39a06cc378552671a4eac2cb80ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.3.0/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e957b9b1034b5a6e8789ff98eb7ef6847ba465c19a58f681cee190414366780e"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
