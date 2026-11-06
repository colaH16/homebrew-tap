cask "tile-launcher@dev" do
  version "2.1.11,80"
  sha256 "850374a79e0e70ada11f04b159825094dbda3dddce1d2e90c2330da87e035d88"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/138065d014022989080d2e1d4ef4959129200e99/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
