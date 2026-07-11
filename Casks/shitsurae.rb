cask "shitsurae" do
  version "1.0.8"
  sha256 "4c42dfd1197cc933771543ec22d91dc6bb41e409821f6d870c1eaa0efb5a6d03"

  url "https://github.com/yuki-yano/shitsurae/releases/download/app-v#{version}/Shitsurae.app.tar.gz"
  name "Shitsurae"
  desc "Workspace arranger"
  homepage "https://github.com/yuki-yano/shitsurae"

  livecheck do
    url :url
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :sequoia

  app "Shitsurae.app"
  binary "#{appdir}/Shitsurae.app/Contents/Resources/shitsurae"

  uninstall launchctl: "com.yuki-yano.shitsurae.agent",
            quit:      "com.yuki-yano.shitsurae",
            delete:    "~/Library/LaunchAgents/com.yuki-yano.shitsurae.agent.plist"

  zap trash: [
    "~/.config/shitsurae",
    "~/.local/state/shitsurae",
    "~/Library/Logs/Shitsurae",
  ]

  caveats <<~EOS
    +======================================================================+
    |                                                                      |
    |  REQUIRED STEP - Run this command before launching Shitsurae:        |
    |                                                                      |
    |      xattr -dr com.apple.quarantine /Applications/Shitsurae.app      |
    |                                                                      |
    |  This removes macOS Gatekeeper restrictions for unsigned apps.       |
    |  Only do this if you trust: https://github.com/yuki-yano/shitsurae   |
    |                                                                      |
    +======================================================================+

    Current releases are not signed or notarized with an Apple Developer ID.
    If macOS still blocks launch, run:
      xattr -dr com.apple.quarantine /Applications/Shitsurae.app
  EOS
end
