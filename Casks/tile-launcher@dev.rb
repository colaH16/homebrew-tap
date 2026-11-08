cask "tile-launcher@dev" do
  version "2.2.0,84"
  sha256 "6fdcb1a29ec9ffb4e0f3cabf316f5ba12c988234b62c31f662df3ab7f562b164"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/9276cebe0dd40e969686927f26c03e2216090cc8/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized Focus-profile diagnostic test build.
    Profile diagnostics are off by default; right-click the menu-bar icon to start.
    Diagnostic trial only; not eligible for stable publication.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
