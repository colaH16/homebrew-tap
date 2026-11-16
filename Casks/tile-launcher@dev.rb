cask "tile-launcher@dev" do
  version "2.3.1,87"
  sha256 "44422ce67be79dfc213eb9e6a444c067c2e6e622cc4e9702ab1735a98d217378"

  # Immutable release asset; the query labels the declared version.
  url "https://api.github.com/repos/colaH16/tile-launcher/releases/assets/754967910?version=#{version.csv.first}",
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
    Same Developer ID signed and Apple notarized 2.3.1 (87) build as stable.
    Diagnostic features are excluded from this public build.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
