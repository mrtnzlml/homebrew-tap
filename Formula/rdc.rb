class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.10.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.0/rdc-0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "5c1d778f7df288dbb6206616c6c9aa2bd0fbe880e660cc58b74f5f2b79f1c364"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.0/rdc-0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "a2cc3a748b28ea703154ee56eae091c8f8efbe9eeaa26fa1bd17ea1e287fe292"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.0/rdc-0.10.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec10fe33e44c32fa48f5628a84803f74e083e0e1637f3750b18588773fcaf070"
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
