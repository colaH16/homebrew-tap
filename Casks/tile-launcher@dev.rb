cask "tile-launcher@dev" do
  version "2.1.10,77"
  sha256 "47e1f9c092e3760a5ecf24d9c4a1d6156046c76700bf12a2fb72379ac6c75f30"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/9fa1ae4e4fd5d59f1efd9ddb16d5464e5e8dce0d/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized test build.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
