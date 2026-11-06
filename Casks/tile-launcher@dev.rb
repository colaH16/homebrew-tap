cask "tile-launcher@dev" do
  version "2.1.11,78"
  sha256 "e980c490d87fff37e9451f49b526b98ecddcc4b7d7f798feae872948e82a6470"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/8e255517e9d4ecc3b175a4ced784dca24f71e644/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized diagnostic test build.
    Menu capture logging is off by default; start with --menu-capture-log to enable.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
