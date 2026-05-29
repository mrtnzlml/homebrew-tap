class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.2.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-aarch64-apple-darwin.tar.gz"
      sha256 "43a04b06bf974a330411debf349c28e2af360ca200a51072c22d7f2290e62b45"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-x86_64-apple-darwin.tar.gz"
      sha256 "a6116955bfdc4cdaa5bfe2842e3685dd30aef07e237eba6cec024ed48852b65d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.2.0/rdc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "690784d3cd3a2d427aef2949123489e1100fba1aa9b90ba2be93f6b87b62ca21"
    end
  end

  def install
    bin.install "rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
