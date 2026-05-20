class Termus < Formula
  desc "Terminal music player that generates ambient, jazz, lofi, classical, and more in real time"
  homepage "https://mrbrutti.github.io/termus/"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrbrutti/termus/releases/download/v0.3.0/termus_0.3.0_darwin-arm64.tar.gz"
      sha256 "49cf699457c8ec1813b28e3ed5ea0239d840fec9f7e5761b976d5c6f1d0009bf"
    end
    on_intel do
      # No prebuilt binary for Intel Macs yet — fall back to source build.
      url "https://github.com/mrbrutti/termus/archive/refs/tags/v0.3.0.tar.gz"
      sha256 "a71b55ce15c171d547ae8ca00b63f92bdf2424d1d654854e8b8068f98db05802"
      depends_on "go" => :build
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/mrbrutti/termus/releases/download/v0.3.0/termus_0.3.0_linux-amd64.tar.gz"
      sha256 "8a197fabc39631eeeb1a725027d58a42befc71930be4cd319a8546903c3ca9d6"
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
