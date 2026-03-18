class Kokoro < Formula
  desc "Text-to-speech CLI using Kokoro-82M via CoreML on Apple Silicon"
  homepage "https://github.com/Jud/kokoro-coreml"
  url "https://github.com/Jud/kokoro-coreml.git", tag: "v0.3.1"
  license "Apache-2.0"
  head "https://github.com/Jud/kokoro-coreml.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["16.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    release_dir = Dir[".build/*-apple-macosx/release"].first || ".build/release"
    libexec.install "#{release_dir}/kokoro"
    Dir["#{release_dir}/*.bundle"].each { |b| libexec.install b }

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
