class Iota < Formula
  desc "An agent CLI for the terminal"
  homepage "https://iota.sh"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.11.0/iota-aarch64-apple-darwin.tar.xz"
      sha256 "dfa6a2e2da5f8315dca3dcdc58bc29f6d91ff2cbc915a475e13d1e81a265200e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.11.0/iota-x86_64-apple-darwin.tar.xz"
      sha256 "274b7b7a64da34c4abcd81f3a83d83f74235b6c7fa22573dfa5b74c15e976f2a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/iotash/iota/releases/download/v0.11.0/iota-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2878cf9bcc4683cff72778b058f2c5d0f7256bba6c07dfa09bc1a123aeca20ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iotash/iota/releases/download/v0.11.0/iota-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6f83031b6ff2c7e004dfca9dd2a6018132a352680d542052504c8d3010f05917"
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
