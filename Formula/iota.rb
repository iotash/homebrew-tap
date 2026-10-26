class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.7.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.5/iota-aarch64-apple-darwin.tar.xz"
      sha256 "79c20b605a54a1ef45696d68d942e94fbfde1269c2dc6103e8bb8ef1f1c70626"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.5/iota-x86_64-apple-darwin.tar.xz"
      sha256 "867637726322fad663f2a6fb70f9ddf2de5408b9b1815856a090657d4387b9ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.5/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b5af4e8ae8684c21275120e0e34d0b3d64cfe848c0e54fedefd23131642236ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.5/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e10f5ab40d7d854ffe05bc56e29a0abe0ddc371b43e79b06e19d26baad8dfcf4"
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
