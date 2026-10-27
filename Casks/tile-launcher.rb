cask "tile-launcher" do
  version "2.1.8"
  sha256 "eee0c8ac41bf0e84342c0343bea65b3b1b273335d431c247226350f3c3f16f25"

  url "https://github.com/colaH16/tile-launcher/releases/download/v#{version}/Tile-Launcher-#{version}-arm64.zip"
  name "Tile Launcher"
  desc "Option-key tile overlay for switching windows, launching apps and running menus"
  homepage "https://github.com/colaH16/tile-launcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Tile Launcher.app"

  uninstall quit: "dev.cola16.TileLauncher"

  zap trash: [
    "~/Library/Application Support/dev.cola16.TileLauncher",
    "~/Library/Application Support/TileLauncher",
    "~/Library/Caches/dev.cola16.TileLauncher",
    "~/Library/HTTPStorages/dev.cola16.TileLauncher",
    "~/Library/Preferences/dev.cola16.TileLauncher.plist",
  ]
end
