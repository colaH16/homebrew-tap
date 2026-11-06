# Tile Launcher diagnostic dev 2.1.11 (80)

Developer ID signed and Apple notarized diagnostic build. Stable remains2.1.10(77). Build80 preserves dev79 capture behavior and distinguishes the remaining child-menu read failure; it is not a new Numbers capture fix.

## Update

    brew update
    brew upgrade --cask colah16/tap/tile-launcher@dev

Existing app directory and settings are retained. Logging is off by default. A normal launch alone will not produce the detailed diagnostic log.

## Capture one failed Numbers Help click

Quit Tile Launcher normally from its menu, then launch a new process:

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.1.11,80/Tile Launcher.app" --args --menu-capture-log

In Numbers, search Help for the same actionable command that failed before, then click the result once. Wait briefly for resolution (2-second request deadline). A dialog may be cancelled. A parent that only opens a submenu is not an actionable command. Direct menu click and Enter were already confirmed; one failed Help click is enough for this diagnostic.

Quit Tile Launcher normally to finish the bounded asynchronous writes. The file is created on the Mac where this test runs, not automatically on any other Mac.

## Prepare a shareable text copy

Run on the tested Mac:

```sh
/bin/zsh -f <<'SH'
capture_logs=("$(getconf DARWIN_USER_TEMP_DIR)"tile-launcher-menu-capture-*(Nom[1]))
(( ${#capture_logs} )) || { print 'No diagnostic log found.'; exit 1; }
capture_dir=$(mktemp -d) || exit 1
cp "$capture_logs[1]" "$capture_dir/TileLauncher-menu-log.txt" &&
open -R "$capture_dir/TileLauncher-menu-log.txt"
SH
```

Attach the selected TileLauncher-menu-log.txt file to the chat. The original is preserved. Restart normally without the logging argument to return to ordinary operation.

## Detail recorded

The existing deferred incomplete event gains a first-failure enum: countError, negativeCount, countUnavailable, copyNotAttempted, copyError, missingArray, arrayDecode, countMismatch or elementType. Available fields include API error codes, reported/requested/returned counts and first invalid item index. Fields from unreached stages remain absent. There are no added per-node events or AX queries.

No search terms, menu titles, document/window text, raw AX objects/values, keys, app names or coordinates are added. The owner-only unique local file is bounded by10minutes/1MiB/200accepted records and32pending writes. Async records can be dropped when full. No automatic upload occurs.

The diagnostic algorithm preserves the existing failure policy, query order, timeout, node/child/depth limits and capture gate. Runtime logging off in this diagnostic-compiled build still retains small helper/trace CPU overhead; timing identity is not claimed. A new diagnostic build is not automatically eligible for stable publication.
