cask "tile-launcher@dev" do
  version "2.3.0,86"
  sha256 "4b4bc6d9a4d1315926845225d82c632282abc94328de62a02635d9965e28caeb"

  # Immutable release asset; the query labels the declared version.
  url "https://api.github.com/repos/colaH16/tile-launcher/releases/assets/723436829?version=#{version.csv.first}",
      header: ["Accept: application/octet-stream", "X-GitHub-Api-Version: 2022-11-28"]
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
    Same Developer ID signed and Apple notarized 2.3.0 (86) build as stable.
    Profile and menu diagnostic features are excluded from this public build.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
