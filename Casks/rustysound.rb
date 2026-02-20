cask "rustysound" do
  version "0.1.66"
  sha256 "8c82ae0fb5183d60a224c9784217e8eaf63b6d0a7059fcb2a437efa6189e65d5"

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
