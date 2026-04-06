class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  version "0.10.1"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.10.1/kokoro-0.10.1-macos-arm64.tar.gz"
  sha256 "fb1b39ea28c63d8d7c4b6b10e2af1de91a226aa8a2e1e68b4a544489da789701"
  license "Apache-2.0"

  depends_on :macos
  depends_on arch: :arm64

  def install
    libexec.install "kokoro"
    Dir["*.bundle"].each { |b| libexec.install b }

    (bin/"kokoro").write <<~SH
      #!/bin/bash
      cd "#{libexec}" && exec ./kokoro "$@"
    SH
  end

  def post_install
    ohai "models (~99MB) will download on first run"
    ohai "try: kokoro say \"hello from homebrew\""
    ohai "all voices: kokoro say --list-voices"
  end

  test do
    assert_match "kokoro", shell_output("#{bin}/kokoro --help")
  end
end
