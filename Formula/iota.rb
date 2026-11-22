class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "0210e607cba01c8aab06dd3e343b1979c779ac43a7b913e51bcc36a40745ce20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "386e96f54ab837586f61f45812c2009bdf5c4e0616fbd3ca500fb480093069d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.13.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e338eaeeec63a241eaa35734b8431096fbd5a28f6e9e8858780a9811d8153fb5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.13.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a99bfd12b65f02661d8a789064d10665d489bf5c5ecc78da64e96e8ecc5b2542"
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
