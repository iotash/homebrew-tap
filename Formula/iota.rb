class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.1.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "9473f7bee1f7a6857d0bf7581e62d0418034ba796bfd48ce7f851d3108a8b7bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.1.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "d7de42422d7dcfc53d6f62f698a9a2dad692b73d39998af48a5dc7b6cb02dd5c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.1.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0bf8cead7bc94e871b502eecd1f2c38e73410bc029f9fe4777b5a6d6c4d4b5cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.1.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4704b6b45ab8e190f725c6e50760145eb5643fb51daa5635266de2d2efccd024"
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
