# colaH16/homebrew-tap

Personal Homebrew tap.

```sh
brew tap colah16/tap
```

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
