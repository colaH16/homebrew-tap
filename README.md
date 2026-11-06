# colaH16/homebrew-tap

Personal Homebrew tap.

```sh
brew tap colah16/tap
```

## Formulae

| Formula | Description |
|---|---|
| `uxplay` | [UxPlay](https://github.com/FDH2/UxPlay) AirPlay server from the [colaH16/UxPlay](https://github.com/colaH16/UxPlay) fork. Bottle for Apple Silicon, macOS 27+; builds from source elsewhere. `brew services` runs it as an audio-only receiver next to the built-in macOS AirPlay Receiver. |

### uxplay

```sh
brew install colah16/tap/uxplay
brew services restart colah16/tap/uxplay
```

The service shows up on iPhone/iPad as "*Computer Name* 오디오". Pick it as the
audio output: video stays on the device and sound plays on the Mac, in sync,
with about 1 s of start delay (classic AirPlay receivers such as shairport-sync
on macOS take about 2 s).

Options live in `$(brew --prefix)/etc/uxplayrc`, written on first install and
never overwritten by upgrades:

| Option | Why |
|---|---|
| `vs 0` | No video window: audio only. |
| `async` | Delays audio to match the sender's video delay, so lips stay in sync. |
| `p 7200` | Fixed ports 7200–7202; the built-in receiver holds 5000/7000. |
| `m 02:…` | Device ID derived from this Mac's hardware UUID, never the built-in receiver's. |

macOS asks twice after install (and again after upgrades); choose Allow both times:

- **Firewall**: may `uxplay` accept incoming connections.
- **Local Network**, on the first AirPlay connection: `brew services` runs uxplay as a
  launchd agent, which macOS keeps off the local network until allowed
  ([TN3179](https://developer.apple.com/documentation/technotes/tn3179-understanding-local-network-privacy)).
  Without it the AirPlay timing exchange fails (`raop_ntp ... No route to host` in
  `$(brew --prefix)/var/log/uxplay.log`) and audio drifts out of sync. Reconnect
  after allowing; the setting lives in System Settings › Privacy & Security › Local Network.
  The formula embeds an Info.plist in the executable so macOS can ask.

Source and bottle: the fork is upstream UxPlay 1.73.7 plus one `-async` fix (a clock
offset guessed before NTP synced made audio play ahead of the video), described in its
[FORK.md](https://github.com/colaH16/UxPlay/blob/v1.73.7-cola.1/FORK.md). The bottle and
the sources of its statically linked libraries (libplist, OpenSSL) are attached to the
fork's [release](https://github.com/colaH16/UxPlay/releases/tag/v1.73.7-cola.1).

## Casks

| Cask | Description |
|---|---|
| `lowtide` | [LowTide](https://github.com/colaH16/LowTide) — Quits chosen apps (Google Drive, OneDrive, …) on Low Data Mode, hotspots or battery. Notarized release from GitHub. Apple Silicon, macOS 13+. |
| `tile-launcher` | [Tile Launcher](https://github.com/colaH16/tile-launcher) — Option-key tile overlay launcher. Notarized release from GitHub. Apple Silicon, macOS 26+. |
| `tile-launcher@dev` | Tile Launcher development test channel. Developer ID signed and Apple notarized diagnostic trial. Shares stable settings. |
| `xld` | X Lossless Decoder. Kept here because `homebrew/cask` disabled it on 2026-09-01 (`:fails_gatekeeper_check`). |

### tile-launcher@dev

Developer ID signed and Apple notarized trial 2.1.11 (79), distributed
from this tap's dev-builds branch. Stable tile-launcher remains 2.1.10 (77).
This build keeps the Option press cursor anchor and trials deferred capture of
Help-search result clicks. The fix runs normally without enabling diagnostics;
behavior across apps is awaiting user testing.

Existing dev installations keep their app directory and settings:

    brew update
    brew upgrade --cask colah16/tap/tile-launcher@dev

Menu capture logging is off by default and requires a new app process with
--menu-capture-log. See the [diagnostic test guide](https://github.com/colaH16/homebrew-tap/blob/d800e048ff485bfc7c9c903a89673298cad55d0b/tile-launcher/2.1.11-79/diagnostic-guide.md) for normal quit,
startup, functional comparisons and finding the bounded local log.
The log contains no search terms, menu titles, document/window text or raw coordinates.

Only one channel can be installed because both use the same app and settings.
Switch without --zap to preserve settings; pass --appdir when installing if you
use a custom app directory. You may keep the dev channel installed when a
tested build becomes stable; completed notarized builds are also delivered here.

### xld

The cask downloads the **official, unmodified** upstream DMG from SourceForge (pinned by `sha256`).
Nothing is rebuilt or redistributed here.

The upstream app is not notarized, so a `postflight` step removes the
`com.apple.quarantine` attribute after install. Gatekeeper's malware scan is
skipped for this app — install it only if you trust the upstream build.

```sh
brew install --cask colah16/tap/xld
# or into a custom folder
brew install --cask --appdir="$HOME/Applications/Media Pro" colah16/tap/xld
```

`auto_updates true`: updates are handled by XLD's built-in Sparkle updater,
so `brew upgrade` skips it unless `--greedy` is used.

## License

Cask definitions are derived from [Homebrew/homebrew-cask](https://github.com/Homebrew/homebrew-cask)
and distributed under the BSD 2-Clause License. See [LICENSE](LICENSE).
The applications installed by these casks are subject to their own licenses.
The `uxplay` formula is this tap's own (BSD 2-Clause). The software it installs, UxPlay
and the colaH16 fork's change, is GPL-3.0-or-later; its bottle also contains libplist
(LGPL-2.1-or-later) and OpenSSL libcrypto (Apache-2.0), whose license texts are installed
to `share/doc/uxplay/`.
