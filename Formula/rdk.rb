class Rdk < Formula
  desc "Retrieval Development Kit — distributed knowledge infrastructure"
  homepage "https://rdk.network"
  version "1.0.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.4/rdk-macos-arm64.tar.gz"
      sha256 "a67feccc96d50f73c19284f1a74a2d227668bad8a9fbf7cb8a7b5b1ee9e09a7d"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.4/rdk-macos-x64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.4/rdk-linux-arm64.tar.gz"
      sha256 "4c8806007c8f5b663e3d6c4deaed390820a81c81b164b5687cec352f320285b7"
    end
    on_intel do
      url "https://github.com/thetechjd/rdk/releases/download/v1.0.4/rdk-linux-x64.tar.gz"
      sha256 "a68112a1f6a3094454be9d94a65665cdb24c5b669cb958f3097b957379c4ede6"
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
