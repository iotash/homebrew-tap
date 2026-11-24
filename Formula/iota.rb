class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.13.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "154f62fb9bc357b2abf0ea74d5c9512a0b27162877d6918a270b1416691a6736"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "e86f8f88cf65494064a97d32521664bae37756c71ee4097278ce2fe3f7d9ca55"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "63b96bd6e6db0101df229c1847f048bdb2e93737f523674ed6c2778c9df5dc68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2bc2ca39a5116160037db1184a3ad36dd40f3a28590124deb8927511aef3b7de"
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
