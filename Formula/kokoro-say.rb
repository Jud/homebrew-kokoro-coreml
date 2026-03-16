class KokoroSay < Formula
  desc "Text-to-speech CLI using Kokoro-82M on Apple Neural Engine"
  homepage "https://github.com/Jud/kokoro-tts-swift"
  url "https://github.com/Jud/kokoro-tts-swift.git", tag: "v0.2.0"
  license "Apache-2.0"
  head "https://github.com/Jud/kokoro-tts-swift.git", branch: "main"

  depends_on :macos
  depends_on xcode: ["16.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/kokoro-say"
  end

  def post_install
    ohai "models (~640MB) will download on first run"
    ohai "try: kokoro-say \"hello from homebrew\""
  end

  test do
    assert_match "kokoro-say", shell_output("#{bin}/kokoro-say --help")
  end
end
