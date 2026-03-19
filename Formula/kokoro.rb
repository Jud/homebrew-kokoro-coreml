class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.5.0/kokoro-0.5.0-macos-arm64.tar.gz"
  sha256 "b8231e954d07203afbda02ee33007491cb8fdab59af846a39633096369293b4a"
  license "Apache-2.0"

  depends_on :macos
  depends_on arch: :arm64

  def install
    libexec.install "kokoro"
    Dir["*.bundle"].each { |b| libexec.install b }

    (bin/"kokoro").write <<~SH
      #!/bin/bash
      exec "#{libexec}/kokoro" "$@"
    SH
  end

  def post_install
    ohai "models (~640MB) will download on first run"
    ohai "try: kokoro say \"hello from homebrew\""
  end

  test do
    assert_match "kokoro", shell_output("#{bin}/kokoro --help")
  end
end
