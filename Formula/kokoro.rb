class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.9.3/kokoro-0.9.3-macos-arm64.tar.gz"
  sha256 "f2f25afaf1b8b620a3856166fe61380a5b89db02dbecc1acdab368e96c9e231e"
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
