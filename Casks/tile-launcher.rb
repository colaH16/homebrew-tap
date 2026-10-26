cask "tile-launcher" do
  version "2.1.6"
  sha256 "cf3bf713cad4ef4928eac0b3dbf99afc7a0071cc91ee708e3786ce4551d737b0"

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
