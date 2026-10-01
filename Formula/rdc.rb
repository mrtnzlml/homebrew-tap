class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.12.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.1/rdc-0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "0d741297a58e5c8cadb74ffb4869d57378a8ada9b37222ef0a6f3b20341a4388"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.1/rdc-0.12.1-x86_64-apple-darwin.tar.gz"
      sha256 "9884e5044073e48d2b5a1ca17fb257befc48ee321196aadfbae0b0fa5d929835"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.1/rdc-0.12.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc6f4eb765c1cd6b57e6cc48cd5a1d8552f5c003d189a8428585ee2e511ffb52"
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
