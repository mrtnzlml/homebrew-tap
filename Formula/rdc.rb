class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.1.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "66e0218317cb7bef2d25aabee5d71cbd61f798f248bff91550de29cc88a1a72e"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "328b427b7a8f0a53b476ceb29a22b09f125653908cf70ef2d409779cb5678aff"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.1.1/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55b750893035ba7e4f772081ae1ba49ed0f913746bef5d8a004157653de22f8a"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
