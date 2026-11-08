cask "tile-launcher@dev" do
  version "2.3.0,85"
  sha256 "fefe82572a9d0ed1e7d86628273e682fb12311dfeee3638e252abe18d2134b97"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/56e1fe858399b22d1d677c1acc34afb5602f3971/tile-launcher/#{version.csv.first}-#{version.csv.second}/Tile-Launcher-#{version.csv.first}-arm64.zip"
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
    Developer ID signed and Apple notarized default-profile/settings UI trial.
    Start normally to test saved defaults and profile creation/duplication UI.
    Optional profile diagnostics are off by default in the right-click menu.
    Company test build only; not eligible for stable publication.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
