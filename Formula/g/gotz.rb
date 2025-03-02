class Gotz < Formula
  desc "Displays timezones in your terminal"
  homepage "https://github.com/merschformann/gotz"
  url "https://github.com/merschformann/gotz/archive/refs/tags/v0.1.13.tar.gz"
  sha256 "8bc7be0a954aedc2bdbbabb27e81d4c257443f6aa784b770294ad56e7cebdaac"
  license "MIT"
  head "https://github.com/merschformann/gotz.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.commit=#{tap.user} -X main.date=#{time.iso8601}"
    system "go", "build", *std_go_args(ldflags:)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gotz -version")
    assert_match "Local", shell_output("#{bin}/gotz -timezones America/New_York")
  end
end
