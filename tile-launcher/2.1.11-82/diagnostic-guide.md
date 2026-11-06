# Tile Launcher development trial 2.1.11 (82)

Developer ID signed and Apple notarized development trial. Stable remains 2.1.10 (77). This build changes Help-search click capture during a normal launch. Numbers and other-app results still need user confirmation; this is a trial improvement, not a confirmed fix. Optional bounded diagnostics remain included and off by default.

## Update

    brew update
    brew upgrade --cask colah16/tap/tile-launcher@dev

Existing app directory and settings are retained. Logging and structural probing are off by default. Updating or reopening an already running process does not enable diagnostics.

## Test normally first

Quit Tile Launcher normally from its menu after the update. Start a new process WITHOUT diagnostic arguments:

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.1.11,82/Tile Launcher.app"

In Numbers, search Help for the same actionable command (for example Export TSV), click its result once, then check Tile Launcher's recent menus. A submenu parent alone is not an actionable command. You do not need to finish exporting; cancel the dialog if desired. The Help-click improvement is active without diagnostics; diagnostic arguments are not required for this test.

## Optional diagnostics only if the failure persists

Quit Tile Launcher normally from its menu. Then launch a new process with BOTH flags:

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.1.11,82/Tile Launcher.app" --args --menu-capture-log --menu-capture-structure

Perform the failed Numbers Help-search click within TEN MINUTES of this new launch. Search for the same actionable command (for example Export TSV) and click its result once. A submenu parent alone is not an actionable command. You do not need to finish exporting; cancel the dialog if desired. Direct-menu and Enter checks need not be repeated for this single-failure diagnostic.

The capture request deadline remains two seconds. The structural probe runs only after a known unsupported SDK role caused the catalog to fail, at most once in this app process, and only if diagnostics can still accept output. API errors, nil/non-string responses and unlisted custom roles produce the classified failure only. The optional probe itself never resumes saving or makes an incomplete catalog complete.

Structural limits: 64 total elements (failed subtree first; optional already-known sibling references share the budget), relative depth4, child count100, per-IPC timeout setting25ms, and the shorter of one second or the original request's remaining time. Cancellation/deadline are checked around calls. The OS may return an IPC later than its configured timeout; these limits are not a hard user-interface latency guarantee. New selection, relevant lifecycle/settings changes or suppression cancel the diagnostic work. No AXParent, new menu root, app-wide/window/document exploration or action is added. Unlisted and app/window boundary roles are not expanded.

Quit Tile Launcher normally after the test to finish bounded asynchronous writes. A fresh normal launch without either argument returns to ordinary operation. Restart with both flags for a new ten-minute diagnostic window if the previous one expired.

## Prepare the log on the tested Mac

```sh
/bin/zsh -f <<'SH'
capture_logs=("$(getconf DARWIN_USER_TEMP_DIR)"tile-launcher-menu-capture-*(Nom[1]))
(( ${#capture_logs} )) || { print 'No diagnostic log found.'; exit 1; }
capture_dir=$(mktemp -d) || exit 1
cp "$capture_logs[1]" "$capture_dir/TileLauncher-menu-log.txt" &&
open -R "$capture_dir/TileLauncher-menu-log.txt"
SH
```

Attach the selected text file to the chat. Preserve the original. Logs exist on the tested Mac and are not automatically transferred from a company Mac to another Mac.

## Recorded metadata and runtime modes

- Normal launch: no diagnostic file and no structural probe. The diagnostic-compiled helpers still have small CPU overhead; identical timing is not claimed.
- --menu-capture-log alone: existing limited log plus classified role failures and context from references already read. No additional structural AX reads.
- --menu-capture-structure alone: no logger and no structural probe.
- Both flags: additionally permits the bounded first-failure structural probe described above.

The existing incomplete event contains fixed failure/type/role enums, numeric AX errors, proven parent/root/depth/index context, bounded role/edge/count metadata, completion/truncation reasons and separate scan/probe durations. Unreadable or truncated regions remain unknown rather than absent. Existing child-read failure details remain available.

No search terms, menu titles, document/window content, raw AX objects/value strings, app names, key strings or coordinates are added. The unique owner-only local file remains bounded by ten minutes/1MiB/200 accepted records/32 pending writes. Records may be dropped at capacity; no automatic upload occurs. Diagnostic-included builds are dev-only and must not be automatically promoted to stable.
