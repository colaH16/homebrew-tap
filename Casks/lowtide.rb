cask "lowtide" do
  version "1.0.0"
  sha256 "056567edf1a810953081d4a416f0c49f458244eb463e9a5be5288828a3a7a89c"

  url "https://github.com/colaH16/LowTide/releases/download/v#{version}/LowTide-#{version}-arm64.zip"
  name "LowTide"
  desc "Menu bar app that quits chosen apps on Low Data Mode, hotspots or battery"
  homepage "https://github.com/colaH16/LowTide"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "LowTide.app"

  uninstall quit: "dev.cola16.LowTide"

  zap trash: "~/Library/Preferences/dev.cola16.LowTide.plist"
end
