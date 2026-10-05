class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.13.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.13.0/rdc-0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "6ed0a14e3b0a44f331e96c7cff00efefefb2d02b4a227bedb0e6c303edc5b706"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.13.0/rdc-0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "f8e1ad5abe7fac5598d39aa54d0770b147d93dad94f80613277060aab36dfc7a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.13.0/rdc-0.13.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef8f18b51bd585ad1aed9f88213862aa0783eabee762d0cda8c30d6819b060b8"
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
