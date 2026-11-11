class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.9.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "648f56c5b6fcc8080e3ef13b871fea5152e4e00e8df3fddd0a246cad39e9410a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.9.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "e105114592f72773e16cc1d5c0b8e72c3ee2e7b230cecf4d04bcf974136f0f4b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.9.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e8999af7ab752c997a4196704887c0ac581209e6b4ac43f0aff95c5ec7a5ab4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.9.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "76a671db6f18324e12eabb4d5324de2dd93d19657a6be401451a24aed5b808f6"
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
