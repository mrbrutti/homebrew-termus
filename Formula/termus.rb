class Termus < Formula
  desc "Terminal music player that generates ambient, jazz, lofi, classical, and more in real time"
  homepage "https://mrbrutti.github.io/termus/"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrbrutti/termus/releases/download/v0.2.0/termus_0.2.0_darwin-arm64.tar.gz"
      sha256 "58e34983efcd5017590a8895097033b9d0fd2eafed96296a1ff1329ef26a46ff"
    end
    on_intel do
      # No prebuilt binary for Intel Macs yet — fall back to source build.
      url "https://github.com/mrbrutti/termus/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "6203942d21a83fe55898b56349bef6ba6f985a4c36e4d05432aeb363b133d29b"
      depends_on "go" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrbrutti/termus/releases/download/v0.2.0/termus_0.2.0_linux-amd64.tar.gz"
      sha256 "908bf62e0342fb233fd7eb5a3660fcbf9a2c689ef0143a49847d0cfdb9140807"
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
