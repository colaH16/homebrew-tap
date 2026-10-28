cask "tile-launcher" do
  version "2.1.9"
  sha256 "33d6f9720d46b79ef739d607a03203f8c0d7313969ef2e4310ad3def7fe1c0e8"

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
