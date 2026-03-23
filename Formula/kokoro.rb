class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.9.4/kokoro-0.9.4-macos-arm64.tar.gz"
  sha256 "10e1a2b21192a7c78b83abf0890123381c0ce1208b4ae6590bf3b27ebe8d3380"
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
    ohai "multilingual: kokoro say --language fr -v ff_siwis \"bonjour\""
  end

  test do
    assert_match "kokoro", shell_output("#{bin}/kokoro --help")
  end
end
