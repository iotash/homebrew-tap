class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.1/iota-aarch64-apple-darwin.tar.xz"
      sha256 "73c63fafc180698587b74e868b510e928e0860ab5c349f950d631b11e5fd21f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.1/iota-x86_64-apple-darwin.tar.xz"
      sha256 "43adc0f8092aa198c4b4a1940ea1ff345d9004279f1195b4176a84a4fd21c8bb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.7.1/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75d9db2710e956ca33f2b9546cd420c977cdb4fe622dae020ce9feddcf289d06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.7.1/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "343ac6c9dcf521162494538ca4bb11c1996eaae6241bf504f4bc648f16562fcb"
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
