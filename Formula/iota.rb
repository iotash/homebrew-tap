class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.7.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.6/iota-aarch64-apple-darwin.tar.xz"
      sha256 "de729561c3c5333abc68aa0a0ff729f8af6befec739e771d05f2c7ea39f6395c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.6/iota-x86_64-apple-darwin.tar.xz"
      sha256 "14818d44631ba6efb27f56106bfa72577cbde2e16021ffe7a1fafd99de84fa4d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.6/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "47de9a70f6ca7e571a0d2edd7c90b3d8ae1e199c3814f67dc13387db00429c99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.6/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "04684d0b72c7d1c4abc7c1419d73c94ff5cfff51ba9c7fb3a0cf356621c8d125"
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
