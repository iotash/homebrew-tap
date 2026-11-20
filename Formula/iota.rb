class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.12.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "bc5a4988468afb17796adb9d0345b04d627bccc7d0740d65136d46086ed48646"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.12.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "5fb8f8c460fc69c83e86a98ed3a2a6fd7ffc0db068763b656d43b9087a517ec2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.12.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "84f616ab98f4992fb644b5c1bb43c5f2e9419c4b631e42ff4e9f97d55fb266df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.12.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0e5ec971901c83773b593f3ea2be8b270552878f019a5d3986944360e0004e5f"
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
