class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.13.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.2/iota-aarch64-apple-darwin.tar.xz"
      sha256 "712fbf16e22d3041d716f66463c3d41333c92b2c50f2570392d61f926139ad36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.2/iota-x86_64-apple-darwin.tar.xz"
      sha256 "af73c452bbb24e292c5a0cde0de547d673ea3b268c1c4f737e33ffaaf36c6b47"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.2/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "39a19c1b683da2c556b84351cfd671bfe7b24feed63c50a95f241555f95fe64d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.2/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5f78544ffd49c7f21807fa6bd4b8eb23c4998879fa4379ffcd15fcc5c18cfe41"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "iota"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "iota"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "iota"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "iota"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
