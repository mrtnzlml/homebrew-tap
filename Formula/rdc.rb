class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.8.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.8.0/rdc-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "f0a6ebf8177b45b0d24ced6953dc45c2fb3c5e68459a987eee761c63075c7b63"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.8.0/rdc-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "aa038740f035102c6ddcfb9dec7dcdd6e205fb9a711dae3a557c52b97f7ea32e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.8.0/rdc-0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d325ee2771ca3876772098a27ad56fcf7b9c680910064acff4f1767626e5961"
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
