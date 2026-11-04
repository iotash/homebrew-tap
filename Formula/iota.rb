class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.7.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.7/iota-aarch64-apple-darwin.tar.xz"
      sha256 "461be48537ff314689e0840bbe1e71b0a6b5b508511755670d5b2e09badfc84a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.7/iota-x86_64-apple-darwin.tar.xz"
      sha256 "afe4b76886610e79f49ba9b15401ee7df76db361df2dfc424650e12d0a3d6748"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.7/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eed9fdb8e99ec7edde6974d723c7cb7d2daf0b69384e550fd8ca49c58e411524"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.7/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed1bb05746467462138651207517692c9b750c41b2de8f0cea3d5c8c32e4f63d"
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
