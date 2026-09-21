class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.2/iota-aarch64-apple-darwin.tar.xz"
      sha256 "24bc5e96877a64a2981b5a06bfdc1a5036a8db592b8aed2c7474040b3334c952"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.2/iota-x86_64-apple-darwin.tar.xz"
      sha256 "044a48388cc008a2511ae3624128efbeca27d698428fa6feeadd596a975cfd20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.3.2/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4c02a52671c83167b42d96976fdc812e05526a2ba99c8606e2f64b8d2a649b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.3.2/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a1a6bdf9420473a5c1fd61276238c5a84ed3d2818277cd3fbba13e8c7eb5bef8"
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
