class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.14.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.1/rdc-0.14.1-aarch64-apple-darwin.tar.gz"
      sha256 "01180560ab20720990fa7c07e04f76a28eb8d4f96b60609e405f224f1988e88f"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.1/rdc-0.14.1-x86_64-apple-darwin.tar.gz"
      sha256 "2f6a4fdec2b1dcf6d930db45a70bce703f5b4c0f512aca9dc01bece36d337b71"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.14.1/rdc-0.14.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a58e28b3a5f2ac530d8479364a1fd8ccb1f2e7fd32b0a2ebc478de92950999da"
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
