class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.15.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-aarch64-apple-darwin.tar.gz"
      sha256 "da0843f8e835ef52b0cf880e8ebf2c10661e42c2eed0f2c41d43339d085b9f0f"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-x86_64-apple-darwin.tar.gz"
      sha256 "5f07aebd9564f5741219e74067eace011b6681562eebff16b8f52cba29a9a492"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.0/rdc-0.15.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c18104bdcee5e16302a47620ce9d2745258a99c5b8294ad905d41bff8bbf51a1"
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
