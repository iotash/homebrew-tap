class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.2/iota-aarch64-apple-darwin.tar.xz"
      sha256 "df6884123f3172bb2f5f0ed6b986b895cf115d3eb4d8d87a8e9ea7a2ce5500e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.2/iota-x86_64-apple-darwin.tar.xz"
      sha256 "ce17772ea06785641386a22c1bf9c94b284fc9475de4f2bee037c0804eb811ae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.5.2/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "32e124995bd9e7db480bdd3ecb59ef99b1c3c9eafbb5b5a1543e28897121cd2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.5.2/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "591a10799cdf7f49f2f75a940faae5497bba779dc31173d816ce64e6928d2bbc"
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
