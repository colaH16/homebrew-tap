cask "tile-launcher@dev" do
  version "2.1.9,76"
  sha256 "3e8ae4c442988f3886ac06b9266aef095eb29b4aea56eb42cef0b3badf378c82"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/4312a83f62ed971146027fffce9a5af8b8b37a61/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-build#{version.csv.second}-arm64-unnotarized.zip"
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
    Developer ID signed test build; not notarized by Apple.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
