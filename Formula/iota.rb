class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.14.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.14.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "179444c47b1597f4deffda5d4cbde1d1323b2a36c17eeee1f24e248d9cf846c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.14.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "ec664f5275d7947935252ff4aceb1e8abc17dee19cd9cae62c7814a0175ff07d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.14.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9432b62328a0ba41f35924acd9e7f8f27b1658c4ca82bf4b1f7bdc084b3a2495"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.14.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb33109ac1184cd9b8c8420c973960483559bb36378ace3002f60555d454e87b"
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
