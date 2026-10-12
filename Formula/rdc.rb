class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.14.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.0/rdc-0.14.0-aarch64-apple-darwin.tar.gz"
      sha256 "146ecdf01f8335089a676fb83ea5744861fa295a7dc08134e8b87ad22269f0a6"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.0/rdc-0.14.0-x86_64-apple-darwin.tar.gz"
      sha256 "0137065fb928c3e9c8c68216a18b9fa4acb6c7a855d9b0fb4b39ef3f87d744b7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.0/rdc-0.14.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b4e318324ea2aa74c2be8370cf7570cdd150c4f37ed6a8fe5275e11e847ef9e"
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
