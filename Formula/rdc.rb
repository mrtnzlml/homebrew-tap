class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.15.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.1/rdc-0.15.1-aarch64-apple-darwin.tar.gz"
      sha256 "bfad3fbe9a7155e1fded9e4d669bf044222001e1acf4b1cce6b0dab89ddaf987"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.1/rdc-0.15.1-x86_64-apple-darwin.tar.gz"
      sha256 "e5dc28534fccd359aa98a1843f7a1f447a82ab16542e4f6db55a0f8d00541720"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.15.1/rdc-0.15.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a7f31cd5d7c75df4ba3f9c21f1c633a39663377ec09a7ec75635ef8545cb7d0"
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
