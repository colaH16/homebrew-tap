cask "tile-launcher" do
  version "2.1.10"
  sha256 "47e1f9c092e3760a5ecf24d9c4a1d6156046c76700bf12a2fb72379ac6c75f30"

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
