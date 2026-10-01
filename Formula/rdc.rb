class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.12.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.0/rdc-0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "3e87a1d3c634d3dac6ffe820ec805c1b41d292c90a4257666be0e1daf39d7df7"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.0/rdc-0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "01b4b740c7e4eab2a2bd69ec1d89cfd337ea1b407a69d0fa3a95a587f68465f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.12.0/rdc-0.12.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afed6a4656a6e8fca332f754276f96460220ee971d538f5f2efa6e904db65474"
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
