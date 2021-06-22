require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-3.38.5.tgz"
  sha256 "6a52a39ebd587470a1aadb7cbe5f1f0e2ddc7cbf580c882f40e51207e64a40af"
  license "MIT"
  head "https://github.com/netlify/cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "54bd49bcf9d2898e0834ca038fbcaa57799c35eaa0f691e299e027a5f0e4897f"
    sha256 cellar: :any_skip_relocation, big_sur:       "5a9b0294cd716a46a71369d66e4737d730f22eaa42bef859a30de5bc43233810"
    sha256 cellar: :any_skip_relocation, catalina:      "5a9b0294cd716a46a71369d66e4737d730f22eaa42bef859a30de5bc43233810"
    sha256 cellar: :any_skip_relocation, mojave:        "5a9b0294cd716a46a71369d66e4737d730f22eaa42bef859a30de5bc43233810"
  end

  depends_on "node"

  uses_from_macos "expect" => :test

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
