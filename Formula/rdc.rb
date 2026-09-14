class Rdc < Formula
  desc "Rossum Deployment as Code -- CLI for snapshotting and deploying Rossum.ai configurations"
  homepage "https://github.com/mrtnzlml/rdc"
  version "0.10.1"
  license "WTFPL"

  on_macos do
    on_arm do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.1/rdc-0.10.1-aarch64-apple-darwin.tar.gz"
      sha256 "746e0fea2941e12b20de70c3bd37480c602e7d326f6ddda73a28781b5d2ba13d"
    end
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.1/rdc-0.10.1-x86_64-apple-darwin.tar.gz"
      sha256 "403a8dc55b860517323ff760296f094d4a2646d7cba05bcedacb0ebd870878bb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrtnzlml/rdc/releases/download/v0.10.1/rdc-0.10.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1c0ea231eeaf7788111fed354fb0d88648b9f8deb119c058da54bb7b981d5d75"
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
