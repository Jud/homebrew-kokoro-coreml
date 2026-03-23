class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml/releases/download/v0.9.0/kokoro-0.9.0-macos-arm64.tar.gz"
  sha256 "238fb7f4cea2490bd9d3b1a60d6a93f5423d1725c94d557b47b22c90b575da35"
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
