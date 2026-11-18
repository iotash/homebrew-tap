class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.11.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.11.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "8a465f8938ba7d31cd19d65e978aa43e434bfb48cfa2687b45e8d743de3f773f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.11.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "d5290dcf9f1cccf378808f090629a091fe8923048e11e38e0f229a6a73071e6b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.11.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c43a804380a9a7e7deb1c4fc7cefc842a92a0556a9d8c82714ec8b54f1b55469"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.11.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "859c59dda34d36670f94b0d2ad4e6897d8dbad5f899de55a0fe8d3de501ed681"
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
