class BitwardenSecretsManager < Formula
  desc "Command-line interface for Bitwarden Secrets Manager"
  homepage "https://bitwarden.com/products/secrets-manager/"
  url "https://github.com/bitwarden/sdk-sm/archive/refs/tags/bws-v1.0.0.tar.gz"
  sha256 "88d25a757ca2f9c1dc727032c600d7c2d90ad4f6c0b3ccac4c1c513120ce34ba"
  license "GPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^bws[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/bws")
  end

  test do
    assert_match "bws #{version}", shell_output("#{bin}/bws --version")
    # Test help output
    assert_match "Usage:", shell_output("#{bin}/bws help 2>&1")
    # Test error output (valid CLI parsing)
    assert_match "error: unrecognized subcommand 'nonexistent'", shell_output("#{bin}/bws nonexistent 2>&1", 2)
  end
end
