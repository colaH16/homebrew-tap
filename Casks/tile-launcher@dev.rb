cask "tile-launcher@dev" do
  version "2.1.11,79"
  sha256 "d8c1c593ccb4c31aae420db044fb86d3584c0634d80a4d04ee84b2f21e8141f3"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/d800e048ff485bfc7c9c903a89673298cad55d0b/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
