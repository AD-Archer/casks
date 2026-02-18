cask "rustysound" do
  version "0.1.56"
  sha256 "c06c9a2a316b4570c71218acb98eb4fb040629791fa03f956ba57427ca4378c0"

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
        2. Or run:
           xattr -dr com.apple.quarantine /Applications/Rustysound.app
    EOS
  end
end
