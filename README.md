# colaH16/homebrew-tap

Personal Homebrew tap.

```sh
brew tap colah16/tap
```

## Formulae

| Formula | Description |
|---|---|
| `uxplay` | [UxPlay](https://github.com/FDH2/UxPlay) AirPlay server, built from the upstream source. `brew services` runs it as an audio-only receiver next to the built-in macOS AirPlay Receiver. |

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

## Casks

| Cask | Description |
|---|---|
| `lowtide` | [LowTide](https://github.com/colaH16/LowTide) — Quits chosen apps (Google Drive, OneDrive, …) on Low Data Mode, hotspots or battery. Notarized release from GitHub. Apple Silicon, macOS 13+. |
| `tile-launcher` | [Tile Launcher](https://github.com/colaH16/tile-launcher) — Option-key tile overlay launcher. Notarized release from GitHub. Apple Silicon, macOS 26+. |
| `tile-launcher@dev` | Tile Launcher development test channel. Developer ID signed and Apple notarized. Shares stable settings. |
| `xld` | X Lossless Decoder. Kept here because `homebrew/cask` disabled it on 2026-09-01 (`:fails_gatekeeper_check`). |

### tile-launcher@dev

Developer ID signed and Apple notarized test build 2.1.10 (77), distributed from
this tap's `dev-builds` branch. Stable `tile-launcher` also provides the same
notarized 2.1.10 (77) build from the upstream GitHub release. You can keep
`tile-launcher@dev` installed when a tested build becomes stable; both channels
receive the notarized build.

The two channels share the same app and settings, so only one can be installed.
Switch without `--zap` to preserve settings:

```sh
brew uninstall --cask colah16/tap/tile-launcher
brew install --cask colah16/tap/tile-launcher@dev
brew upgrade --cask colah16/tap/tile-launcher@dev
```

To return to stable, uninstall `tile-launcher@dev` without `--zap`, then install
`tile-launcher`. Pass `--appdir` when installing if you use a custom app directory.

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
UxPlay is GPL-3.0-or-later; the `uxplay` formula builds the unmodified upstream source.
