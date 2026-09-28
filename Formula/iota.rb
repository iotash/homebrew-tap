class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "f204252ec7bf000a6284c167a6afbefddd4296708208c9075550c094f1b16648"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "850da60ad1882ddfb2796a28db827c5feb451fa39f39f135652adcc6dcdf5dbf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "775fb983ed8b069b51ae4cc255133d2b4a9b13f28a2d1738362e012b6ab4bfbc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "35c994717a58afd6061d43a19d9bd05de418c14c167eccfeb31b76c031ae133e"
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
