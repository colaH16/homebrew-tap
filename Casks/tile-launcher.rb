cask "tile-launcher" do
  version "2.3.1"
  sha256 "44422ce67be79dfc213eb9e6a444c067c2e6e622cc4e9702ab1735a98d217378"

  # Immutable release asset; the query labels the declared version.
  url "https://api.github.com/repos/colaH16/tile-launcher/releases/assets/754967910?version=#{version.csv.first}",
      header: ["Accept: application/octet-stream", "X-GitHub-Api-Version: 2022-11-28"]
  name "Tile Launcher"
  desc "Option-key tile overlay for switching windows, launching apps and running menus"
  homepage "https://github.com/colaH16/tile-launcher"

  livecheck do
    url "https://github.com/colaH16/tile-launcher"
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
