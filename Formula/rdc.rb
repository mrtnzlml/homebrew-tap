class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.15.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "31ed1d9434a59f6766bdacfb371f1c3ce292758b523fc7b1028657cf7d616f92"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "5a47160638d53640d6807aefab087d20dc4910108daf294f938f069fb4a7d325"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "da40fc7ff6426362fdd0117e9b4d407be8be31090832d2ccc5ebe1a8e2d5e8ff"
    end
  end

  def install
    bin.install "rdc"
    # rdc uses clap_complete's dynamic completions: COMPLETE=<shell> rdc
    # emits the registration script. :clap is Homebrew's predefined
    # format for exactly that protocol (bash/zsh/fish by default).
    generate_completions_from_executable(bin/"rdc", shell_parameter_format: :clap)
    # clap's zsh script only registers the completer (it is written for
    # `source <(COMPLETE=zsh rdc)`); autoloaded from fpath as _rdc, the
    # first TAB of a session would no-op. Invoke the completer too.
    (zsh_completion/"_rdc").append_lines "_clap_dynamic_completer_rdc"
  end

  test do
    assert_match "rdc", shell_output("#{bin}/rdc --version")
  end
end
