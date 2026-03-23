class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  version "0.10.0"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.10.0/kokoro-0.10.0-macos-arm64.tar.gz"
  sha256 "d358816fe6d2644ee26c3c21d8f5d44d5027e020c9a489906fc2d223e7503d79"
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
