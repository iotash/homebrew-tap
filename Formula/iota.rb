class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "b37372bb409d69feb1e2230a5e2127019adaeeeea66cca2b374c6913eecbbb0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "db79fc760a6f2943c6b7e116e066ce8592c26d8c9ba6d73f3d100d62fc95f3af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "013327640404368a16fcfc8213091b1e330995098e4a689e3ad293495b92bd6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eadfb9909200010f8ce4969e8252b11f70e5407a9515ded6a13a08f9940cbf32"
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
