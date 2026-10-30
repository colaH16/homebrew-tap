class Uxplay < Formula
  desc "AirPlay Unix mirroring and audio server"
  # Fork of https://github.com/FDH2/UxPlay with one -async timing fix; see its FORK.md.
  homepage "https://github.com/colaH16/UxPlay"
  url "https://github.com/colaH16/UxPlay/archive/refs/tags/v1.73.7-cola.1.tar.gz"
  version "1.73.7-cola.1"
  sha256 "18d8d6f0d3b40c69acb7edb22e4924af91a8dd40cbe1e0c66ee07ea0de808a53"
  license "GPL-3.0-or-later"
  head "https://github.com/colaH16/UxPlay.git", branch: "macos-brew-1.73.7"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+-cola\.\d+)$/i)
  end

  bottle do
    root_url "https://github.com/colaH16/UxPlay/releases/download/v1.73.7-cola.1"
    sha256 arm64_golden_gate: "e5fa188603d929d29fc2a3b6adebf32c1553dd23a55e81fcc662c5cff2544c0e"
  end

  depends_on "cmake" => :build
  depends_on "libplist" => :build # linked statically on macOS
  depends_on "openssl@3" => :build # libcrypto linked statically on macOS
  depends_on "pkgconf" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "gstreamer"
  depends_on :macos

  def install
    # `brew services` runs uxplay as a launchd agent, which macOS blocks from the local
    # network (TN3179) until the user allows it. An Info.plist embedded in the executable
    # lets macOS show the Local Network alert and list "uxplay" in System Settings.
    (buildpath/"Info.plist").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>CFBundleIdentifier</key>
        <string>dev.cola16.uxplay</string>
        <key>CFBundleName</key>
        <string>uxplay</string>
        <key>CFBundleShortVersionString</key>
        <string>#{version}</string>
        <key>NSLocalNetworkUsageDescription</key>
        <string>uxplay exchanges AirPlay timing and audio with iPhone and iPad on your local network.</string>
        <key>NSBonjourServices</key>
        <array>
          <string>_airplay._tcp</string>
          <string>_raop._tcp</string>
        </array>
      </dict>
      </plist>
    XML

    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_EXE_LINKER_FLAGS=-Wl,-sectcreate,__TEXT,__info_plist,#{buildpath}/Info.plist",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    # Re-sign ad hoc so the signature binds the embedded Info.plist and carries its identifier.
    system "codesign", "--force", "--sign", "-", "--identifier", "dev.cola16.uxplay", bin/"uxplay"
    # Optional Bluetooth LE beacon helper: keep the script next to its non-executable module.
    libexec.install bin/"uxplay-beacon.py", bin/"uxplay_beacon_module_BleuIO.py"
    # libplist (LGPL-2.1-or-later) and OpenSSL's libcrypto (Apache-2.0) are linked statically:
    # ship their license texts with the binary (UxPlay's own GPL text is already in doc).
    (doc/"libplist").mkpath
    (doc/"openssl").mkpath
    cp formula_opt_prefix("libplist").glob("COPYING*"), doc/"libplist"
    cp formula_opt_prefix("openssl@3")/"LICENSE.txt", doc/"openssl"

    # Default startup options for `brew services`, kept in etc so upgrades never overwrite edits.
    # Audio-only receiver: no video window, audio synced to the sender's video delay,
    # fixed ports and a per-Mac device ID so it never collides with the built-in
    # AirPlay Receiver (TCP 5000/7000, real MAC address).
    (libexec/"uxplay-init-rc").write <<~SH
      #!/bin/sh
      set -e
      name=$(scutil --get ComputerName)
      uuid=$(ioreg -rd1 -c IOPlatformExpertDevice | sed -n 's/.*"IOPlatformUUID" = "\\(.*\\)"/\\1/p')
      mac=02:$(printf %s "$uuid" | md5 | cut -c1-10 | sed 's/../&:/g; s/:$//')
      cat > "#{etc}/uxplayrc" <<EOF
      # UxPlay startup options for \\`brew services\\` (one per line, no leading "-").
      # See \\`uxplay -h\\`. Apply changes with: brew services restart colah16/tap/uxplay
      n "$name 오디오"
      nh
      vs 0
      vsync no
      async
      p 7200
      m $mac
      EOF
    SH
    chmod 0755, libexec/"uxplay-init-rc"
  end

  post_install_steps do
    unless_path_exists "uxplayrc", base: :etc do
      run "uxplay-init-rc", base: :libexec, writable_paths: ["uxplayrc"], writable_base: :etc
    end
  end

  def caveats
    <<~EOS
      `brew services` reads its options from:
        #{etc}/uxplayrc
      The macOS firewall asks once (and again after each upgrade) whether
      uxplay may accept incoming connections: choose Allow.
      On the first AirPlay connection macOS also asks whether uxplay may access
      the local network: choose Allow, then reconnect. Without it audio cannot
      sync (System Settings > Privacy & Security > Local Network > uxplay).
    EOS
  end

  service do
    run [opt_bin/"uxplay", "-rc", etc/"uxplayrc"]
    keep_alive true
    log_path var/"log/uxplay.log"
    error_log_path var/"log/uxplay.log"
  end

  test do
    # Running uxplay at all needs the macOS GUI event loop (gst_macos_main), which the
    # test sandbox blocks, so check the built binary instead of executing it.
    assert_includes (bin/"uxplay").binread, version.to_s[/^[\d.]+/]
  end
end
