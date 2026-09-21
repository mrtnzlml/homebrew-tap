class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.11.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.11.0/rdc-0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "c16340e85367232408d4a0845d254c7936172241eec9af23220805fc3472b570"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.11.0/rdc-0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "0ed21dbc6d2e89c94ce46e610527cee8e9fbe1f622926cba399b77b2ffe4d3d4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.11.0/rdc-0.11.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3adca28a852cd87f507bc9c942afba6c5cdd8d6e07896e9c7680c1932665cbbe"
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
