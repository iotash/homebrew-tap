class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.2.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "9cc58ad341b7b4be0fd446c50699ef0cef7bce44f56c2cae5d1f2b6d3ef649f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.2.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "5ee358463048a5f4323d21f8b638d8807dc4fa0ce3fc06bd68b13ba03d6ec592"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.2.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6103583f3dae2bd1406d000f733d68a600135b6f3eba171c6943332ba2a845df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.2.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "36fb2292fb475969c3ea6dd8dfbc6e764b8f0a7b02f19cb2469d9de0e2748cd6"
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
