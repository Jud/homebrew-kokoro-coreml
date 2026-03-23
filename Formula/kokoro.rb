class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.8.0/kokoro-0.8.0-macos-arm64.tar.gz"
  sha256 "93d6c755b2a64acc6d06bae1283c6606b254e885ae347a4e102eb20e1a4af646"
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
    ohai "models (~99MB) will download on first run"
    ohai "try: kokoro say \"hello from homebrew\""
    ohai "multilingual: kokoro say --language fr -v ff_siwis \"bonjour\""
  end

  test do
    assert_match "kokoro", shell_output("#{bin}/kokoro --help")
  end
end
