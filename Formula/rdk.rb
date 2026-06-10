class Rdk < Formula
  desc "Retrieval Development Kit — distributed knowledge infrastructure"
  homepage "https://rdk.network"
  version "1.0.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.5/rdk-macos-arm64.tar.gz"
      sha256 "bf54fd548a1f3b9be519e51760e4bdf59bbbe3bc6165ab43401583a5bc3969d0"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.5/rdk-macos-x64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.5/rdk-linux-arm64.tar.gz"
      sha256 "0303e986e7b4545076165fc24ad50d1a915f4b8bcc830280e4123cc0643bffda"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.5/rdk-linux-x64.tar.gz"
      sha256 "9795530f7ba0b62bc965bac01e19595acb795c9eb74d85c71b0670483cefc726"
    end
  end

  def install
    os  = OS.mac? ? "macos" : "linux"
    cpu = Hardware::CPU.arm? ? "arm64" : "x64"
    libexec.install "rdk-#{os}-#{cpu}" => "rdk-bin"
    libexec.install "better_sqlite3.node"
    (bin/"rdk").write <<~SH
      #!/bin/bash
      export BETTER_SQLITE3_NATIVE_BINDING="#{libexec}/better_sqlite3.node"
      exec "#{libexec}/rdk-bin" "$@"
    SH
    chmod 0755, bin/"rdk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdk --version")
  end
end
