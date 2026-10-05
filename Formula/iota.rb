class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "c77b5a6b13912bb303c99397e8521eadddb595f0c13433429115c6612805a651"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "30a3d2dbbe8ed37daa364634d00df43e8e12624e754482362a6fb56460937892"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "15ad7ef8d5b6ebba87bc396a7c03aa78fc0a1025ca9fc0ddd7fc30c6a9cd160a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9128b6f16bdd4bed556f219c03fcc8035de5c1f69cece7cb7dc6b3dce8696c77"
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
