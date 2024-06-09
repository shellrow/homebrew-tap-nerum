class Nerum < Formula
  desc "Simple and Fast Network Mapper"
  homepage "https://github.com/shellrow/nerum"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nerum/releases/download/v1.4.0/nerum-aarch64-apple-darwin.tar.xz"
      sha256 "2caae3190f2d32dae2ad1fda75c07b6a09f053bd47a506b73b18dd38f0467944"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nerum/releases/download/v1.4.0/nerum-x86_64-apple-darwin.tar.xz"
      sha256 "262809cd8b69292d59bcc309b0c75518a382eb085611c82d2094152051f95267"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nerum/releases/download/v1.4.0/nerum-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3069453205c827e3c9537ab0a44791e09b4f2a8e0589bf09a5c4dc54f28753e3"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

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
      bin.install "nerum"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nerum"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nerum"
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
