class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "e3a61efc678dc4f23eb1f4ea1121ec330def407e829f6de7aece8b0c73d3f716"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "c1e49013f17f96f8788cbc2a9bdf7c6c947cd74ecf32093792ed25a4330bb33a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "758dbc54cdaf0a66d578fce467c6e475830e2d5f610592bc8ee5212de2093a73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b692fa898f73350a01858e50746e508aac11af61f09783480fccdd1dc1856024"
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
