class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.14.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.14.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "e2f1b586b46edd49a8f0cb39679b944a8602a948196168fec49d511108b46a59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.14.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "c9b9ffd1c592e7ab0801d214972cc45c51fc730529148c0e780a11b0cf54e4e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.14.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d6276e08930fce27be5535f187cca27291cc00206a49ae08ba2d38ce7dd065c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.14.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "883fa92110113fae56e564a748f1b3b6b0f75d472cad2ce42f3da5e52bb64b4e"
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
