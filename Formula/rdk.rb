class Rdk < Formula
  desc "Retrieval Development Kit — distributed knowledge infrastructure"
  homepage "https://rdk.network"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.0/rdk-macos-arm64.tar.gz"
      sha256 "6b834944337d05f39d25939714f2687700f12be443c51f4b85568ff26eee6637"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.0/rdk-macos-x64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.0/rdk-linux-arm64.tar.gz"
      sha256 "1e9c7d46fac03597723e955f51354defd27b433171674f2727690d3905e28576"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.0/rdk-linux-x64.tar.gz"
      sha256 "81689ef5627f6e1e9f31aea31eee5269aa5f5ae2d0f04697b49edb1e759c428a"
    end
  end

  def install
    bin.install "rdk-#{OS.mac? ? 'macos' : 'linux'}-#{Hardware::CPU.arm? ? 'arm64' : 'x64'}" => "rdk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdk --version")
  end
end
