cask "lowtide" do
  version "1.0.1"
  sha256 "3d1580ab901dcac1c88738bce1d66bb5a75bbdb8d94f1612ca69a5616a4424c5"

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
