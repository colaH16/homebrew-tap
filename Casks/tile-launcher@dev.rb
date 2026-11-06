cask "tile-launcher@dev" do
  version "2.2.0,83"
  sha256 "db192aa63760b330cedd9c08c8a847a09b2d0ddce6bed6d828d252ba52758203"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/86bdacd7b362d22d57e776c1406f8c42190d2cd5/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
  name "Tile Launcher Dev"
  desc "Development test build of the Option-key tile overlay launcher"
  homepage "https://github.com/colaH16/tile-launcher"

  livecheck do
    skip "Development builds are updated explicitly in this tap"
  end

  conflicts_with cask: "tile-launcher"
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Tile Launcher.app"

  uninstall quit: "dev.cola16.TileLauncher"

  # Shares the stable app's settings; intentionally no zap stanza.
  caveats <<~EOS
    Developer ID signed and Apple notarized production-candidate test build.
    Menu paths appear above command titles; start normally to test the UI.
    Engineering candidate only; stable publication awaits user testing.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
