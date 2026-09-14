class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.2.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "bcbcd9dd314cbf63c609edd6e67f239ca530d3ffa5bec3dd7d4cac618236b542"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.2.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "64eb754b923816acf28bfe52b25b94a0e5be67b4bb1455b02b740b032658b1e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.2.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae0dc3482af8742a3364f73ee9c83462953774d27cc105d27a8647e7911103c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.2.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "136fb609ca5126698155566926b6761f326cb69de590d49f97de66acd39effad"
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
