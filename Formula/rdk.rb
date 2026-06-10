class Rdk < Formula
  desc "Retrieval Development Kit — distributed knowledge infrastructure"
  homepage "https://rdk.network"
  version "1.0.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.3/rdk-macos-arm64.tar.gz"
      sha256 "54ff3767cb248e7a3f6984f24086d1ed4b1ac17d02d45da4c24cf48591f50d54"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.3/rdk-macos-x64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.3/rdk-linux-arm64.tar.gz"
      sha256 "1901cb5d44d87b1546fafa91b3f55f87ee9f72a579f42f5c0b454a71abdf0bdf"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.3/rdk-linux-x64.tar.gz"
      sha256 "f02701dd3fdf3019bc832809ce7bf27e62c0b8edb4bc0d39878e7669f28c06ab"
    end
  end

  def install
    bin.install "rdk-#{OS.mac? ? 'macos' : 'linux'}-#{Hardware::CPU.arm? ? 'arm64' : 'x64'}" => "rdk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdk --version")
  end
end
