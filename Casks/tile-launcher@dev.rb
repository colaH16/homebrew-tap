cask "tile-launcher@dev" do
  version "2.1.11,82"
  sha256 "a1759fbe4bc5f7fc72a745947594b5894f6d3c191634239314279055c1f26013"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/194deb3ae4d7872a138022180f09fae3a93b1fbf/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized development test build.
    Help-click capture improvements apply in a normal launch; test without diagnostic flags first.
    Menu capture logging is off by default; start with --menu-capture-log to enable.
    Structural AX probing is separately opt-in with --menu-capture-structure.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
