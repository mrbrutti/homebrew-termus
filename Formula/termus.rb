class Termus < Formula
  desc "Terminal music player that generates ambient, jazz, lofi, classical, and more in real time"
  homepage "https://mrbrutti.github.io/termus/"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrbrutti/termus/releases/download/v0.4.0/termus_0.4.0_darwin-arm64.tar.gz"
      sha256 "df41a6f1005b157d10f3b5132c248b61bd6a35fa0ad931a98cb8e64572600250"
    end
    on_intel do
      # No prebuilt binary for Intel Macs yet — fall back to source build.
      url "https://github.com/mrbrutti/termus/archive/refs/tags/v0.4.0.tar.gz"
      sha256 "c252c8a16219c877cd3d9a357e43986bd806239ef68028d48072a2aec3315450"
      depends_on "go" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrbrutti/termus/releases/download/v0.4.0/termus_0.4.0_linux-amd64.tar.gz"
      sha256 "72f10dccd3878e2a3654525913f07b838fa6a773bfb349ce1e84362132547144"
    end
  end

  head "https://github.com/mrbrutti/termus.git", branch: "main"

  depends_on "go" => :build if build.head?

  def install
    # Build from source on intel-Mac (no binary shipped) and on HEAD installs.
    needs_build = build.head? || (OS.mac? && Hardware::CPU.intel?)
    if needs_build
      ldflags = %W[-s -w -X main.version=#{version}]
      system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"termus"), "./cmd/termus"
    else
      bin.install "termus"
    end
  end

  test do
    assert_match "algorithm name", shell_output("#{bin}/termus --help 2>&1", 0)
  end
end
