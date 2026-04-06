class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  version "0.10.2"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.10.2/kokoro-0.10.2-macos-arm64.tar.gz"
  sha256 "ce2eb85eb806772c756f1ed541eb67672e9450c8446a85a8858ee37afa8bb9f2"
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
