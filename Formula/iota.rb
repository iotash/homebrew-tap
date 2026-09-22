class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.4.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "9cd3a01ac3381f2f869efdbaee97d8f2408648b17c624608de913dd5aa732007"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.4.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "52a4ed042e6eca2eb1e930766851cd7e40d774d8713e6d3ea6db2d574e5edcc6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.4.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91c7c564222b82b4c4f259396cde8e4906d7e3cfc51c2436888742db5db89b00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.4.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eec2ffb2ff696675b421d03596856693bcf504009d342b68e145ffcfafc04777"
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
