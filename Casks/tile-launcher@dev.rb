cask "tile-launcher@dev" do
  version "2.3.1,87"
  sha256 "44422ce67be79dfc213eb9e6a444c067c2e6e622cc4e9702ab1735a98d217378"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/b19a0a33ad73634c92828516361bba6137e851f3/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized 2.3.1 (87) test build.
    Option+number runs immediately; a pinned overlay closes after a run.
    Stable stays on 2.3.0 until user testing passes.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
