class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.9.0"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.9.0/rdc-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "7d6f18951174ce19ca77d2dab08b40e2c9a6c61f6d8ed6aded0c5ab94cbbf8af"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.9.0/rdc-0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "4f5ef1024c939f0a5b95ab18d0c25ae1cbd250384a0e4baa142923e32eb0d40f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.9.0/rdc-0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3739875490d9743568c7e71d7f34ecbc2d3a5005cd4e29920473ead7171405b9"
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
