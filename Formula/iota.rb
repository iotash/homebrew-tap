class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "990f8c8ebabd694d97e786ce14e7cf47875f0bdf986f9bf7bbd6de67d17bb1bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "90ca8b925dd0382eb0cbab79e6a9dd162ab4f9807bf65520216618d17485f997"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "94e2dc8ee7e89a7d9d067402225b08fb0b1c370af407f4afdd2e0ba5390cd16d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9faced3af5f9389992f93ee7b613f00cc5785f1abe3383bebbb04e457dbc5e0f"
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
