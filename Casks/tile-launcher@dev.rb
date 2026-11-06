cask "tile-launcher@dev" do
  version "2.1.11,81"
  sha256 "4337bde0ebd4e36a0d3eccf8bb199b2a2370216ba62e43999187d3b7aae20837"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/cc0c780cc51d35e4ec3f8bcaa3548c83a67a1fc6/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Structural AX probing is separately opt-in with --menu-capture-structure.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
