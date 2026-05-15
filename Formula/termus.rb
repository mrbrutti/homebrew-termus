class Termus < Formula
  desc "Terminal music player that generates ambient, jazz, lofi, classical, and more in real time"
  homepage "https://mrbrutti.github.io/termus/"
  url "https://github.com/mrbrutti/termus/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ef29537f3cca33d42a28d84575a8487f73bc46ec2e930ff453031625b978be25"
  license "MIT"
  head "https://github.com/mrbrutti/termus.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"termus"), "./cmd/termus"
  end

  test do
    # `termus --help` prints flag descriptions and exits 0.
    assert_match "algorithm name", shell_output("#{bin}/termus --help 2>&1", 0)
  end
end
