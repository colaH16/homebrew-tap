cask "tile-launcher@dev" do
  version "2.1.9,75"
  sha256 "bc4664c8c249be635ce927fb5e06396dafebcd8f992de3f291bf8bb04a468141"

  url "https://raw.githubusercontent.com/colaH16/homebrew-tap/d275c9db6cd5e31a6e12cf24c86dbfe5ffb25f50/tile-launcher/2.1.9-75/Tile-Launcher-2.1.9-build75-arm64-unnotarized.zip",
      verified: "raw.githubusercontent.com/colaH16/homebrew-tap/"
  name "Tile Launcher Dev"
  desc "Development test build of the Option-key tile overlay launcher"
  homepage "https://github.com/colaH16/tile-launcher"

  livecheck do
    skip "Development builds are updated explicitly in this tap"
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  conflicts_with cask: "tile-launcher"

  app "Tile Launcher.app"

  uninstall quit: "dev.cola16.TileLauncher"

  # Shares the stable app's settings; intentionally no zap stanza.
  caveats <<~EOS
    Developer ID signed test build; not notarized by Apple.
    Shares settings and the app location with tile-launcher.
    Switch channels with brew uninstall, without --zap.
  EOS
end
