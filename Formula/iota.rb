class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "3fb32d1499432fd9b4913dd04b2c679e6e827df3d3700508dffde7f6d4f5567f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "499c10df8a865bf8ae47d0b2ae56ae3271753d18fad4b1ef9392cb3b36f3b14c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0acf76f0a45e538a9c27b1591ddd58efaefc0c7b192f6220311d1f659612cc61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3777839aec690496f03be3c94dac4796b1c88cdb591ff15d8119a72c118d0451"
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
