class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.10.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "01eacac678189d334a6f4f2fbda8dfd30c2d02b4281abe40ea092b695024b238"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.10.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "6072220f4bfc3a0573b0625cdcddec606d20691df2f69c15e57bd92a4621ebc5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.10.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e5239c40b6debab961127d303f0fa30cd2a0b9248ce2df11d66f9db99d476b8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.10.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3eaa047396311d036fd5e82b79b04805295ae97dcdcd6ae1297d52b63fb56191"
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
