class Rdk < Formula
  desc "Retrieval Development Kit — distributed knowledge infrastructure"
  homepage "https://rdk.network"
  url "https://registry.npmjs.org/@retrodeck/rdk/-/rdk-1.0.8.tgz"
  sha256 "9c7db6072b719cae6ee0a7d7e3774d33c46ed8fde31120a402b3a379c42a75d2"
  license "MIT"

  # Pin a stable Node that better-sqlite3 publishes prebuilt binaries for.
  # Homebrew's default "node" tracks bleeding-edge releases whose ABI often
  # has no matching prebuild, forcing a source build that fails in the sandbox.
  depends_on "node@22"

  def install
    node22 = Formula["node@22"]
    ENV.prepend_path "PATH", node22.opt_bin

    # Install by name from the registry (NOT the local dir — npm symlinks local
    # dirs and skips their deps). This installs the full dependency tree and runs
    # prebuild-install, downloading the better-sqlite3 binary for node@22's ABI.
    system node22.opt_bin/"npm", "install", "--global", "--prefix=#{libexec}", "@retrodeck/rdk@#{version}"

    # Wrap so `rdk` always runs under node@22 — same ABI the binary was fetched for.
    (bin/"rdk").write_env_script libexec/"bin/rdk", PATH: "#{node22.opt_bin}:$PATH"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdk --version")
  end
end
