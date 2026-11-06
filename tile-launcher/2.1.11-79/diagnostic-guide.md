# Tile Launcher dev 2.1.11 (79)

Developer ID signed and Apple notarized Help-search click trial. Stable remains 2.1.10 (77). This dev build also keeps the Option-press cursor anchor from dev78.

## Update the existing dev channel

    brew update
    brew upgrade --cask colah16/tap/tile-launcher@dev

The existing app directory and settings are retained. Open Tile Launcher again after upgrading. The fix is active in a normal launch; logging does not need to be enabled.

## Functional test

In Numbers and other apps you use, choose an actionable leaf command in Help search and click the result. Do not choose a parent that only opens a submenu. After a short pause, check that the command appears in Tile Launcher's collected menus. You may cancel a dialog the command opens, including with Esc.

Compare with a direct menu click and Help-search Enter if needed. Confirm that menus and normal clicks stay responsive. Existing entries may only update usage rather than create a duplicate. Full AX resolution has a 2-second request deadline; incomplete or ambiguous results are deliberately not saved. Actual behavior across apps still needs this dev trial.

## Optional diagnostic session

Only needed if investigating a remaining omission. Quit Tile Launcher normally from its menu, then start a new process:

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.1.11,79/Tile Launcher.app" --args --menu-capture-log

Run the three comparison paths promptly. Find the local log:

    find "$(getconf DARWIN_USER_TEMP_DIR)" -maxdepth 1 -type f -name 'tile-launcher-menu-capture-*' -mmin -15 -print

There is no settings switch and adding an argument to an already-running process does not enable logging. A normal restart without the argument disables it.

The unique owner-only local file is limited to 10 minutes, 1 MiB, 200 accepted records and a bounded pending queue. Logging is asynchronous and records may be dropped when full. It contains no search terms, menu titles, document/window text, key strings, raw AX values or coordinates and is not uploaded automatically.

The deferred stage records selection sealing, start, complete/unresolved or incomplete reason, queueing and recording/rejection, with request ID, counts and relative timings. A timeout or failure is not proof that no menu command exists.

## Scope

Normal menu close and unrelated dialog input preserve a confirmed choice. A new menu interaction, app/process/settings change, stop or launcher suppression invalidates older work. The current exposed AX menu tree is read completely; lazy or custom menus may remain unsupported. This diagnostic dev build is not automatically eligible for a stable release.
