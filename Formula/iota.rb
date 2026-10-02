class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "5f6efd7ac2491ad8f21b6748ac079eb151cf577b8a0bee6c5bb6aed9a3d55fea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "daa407ba455ef3bc95f95a523b7c37c3da81a36d42bced938c2c0c68a27f9f26"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6679d4ff8fc6a4b6ca614ddba4e78a63373cecb3be41363dd8eafe6f29e4c9f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.6.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6d7b899b2c00e823eda5d426f8dcc90efd653bbbcd04063dca107fb374af5775"
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
