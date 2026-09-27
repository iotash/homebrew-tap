class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "a86d5fdd4373b7da95d8ef612647262a911d05c79a7f31bb1d39f6a2199728c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "9bb63cd7e2ae9934d6cfac3b1817bb16ee8f9443ed953dd9bf1b36c976c43578"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "719bc779aab9ea60ad8814b38f72c878e85df479e45c3222a8f7cd0b1c52d8c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "499adbcff0e5aacef6fdbbb8c4a0b4deb9df034a46ac63fc7e0dd71ac46fba9a"
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
