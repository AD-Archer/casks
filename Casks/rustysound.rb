cask "rustysound" do
  version "0.1.59"
  sha256 "b8d4e643ca4369e1e269e928392945e1e39b7d6795b8282b9bdb27b33ffea792"

  url "https://github.com/AD-Archer/RustySound/releases/download/v#{version}/Rustysound.dmg"
  name "RustySound"
  desc "Music streaming client for Navidrome and Subsonic servers built in Rust"
  homepage "https://github.com/AD-Archer/RustySound"

  app "Rustysound.app"

  caveats do
    <<~EOS
      RustySound is unsigned, so macOS may block it on first launch.

      If it is blocked:
        1. In Finder, right-click Rustysound.app and choose Open.
        2. Open settings > Security & Privacy > General, and click "Open Anyway" for Rustysound.
        3. Or run:
           xattr -dr com.apple.quarantine /Applications/Rustysound.app
    EOS
  end
end
