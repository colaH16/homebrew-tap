# Tile Launcher 2.2.0 (83) UI trial

Developer ID signed and Apple notarized trial. Stable remains 2.1.10 (77). This build is an engineering candidate; stable publication awaits user testing.

## Update and start normally

    brew update
    brew upgrade --cask colah16/tap/tile-launcher@dev

Existing app directory and settings are retained. Quit Tile Launcher normally after the update, then start a new process:

    open -g "$(brew --caskroom colah16/tap/tile-launcher@dev)/2.2.0,83/Tile Launcher.app"

## Check menu paths

With tile labels enabled, open the overlay and inspect normal-size menu tiles using an icon, saved image, symbol or shortcut glyph. If they already have a known saved parent path, that path appears above the command title. Tiles without a known saved parent path omit the extra line. Small tiles, text-only glyphs and the legacy labels-off layout keep their existing presentation.

Check a long path: the displayed path shortens with an ellipsis to fit the tile. Hover over the menu tile to confirm that its tooltip shows the full known menu path. Check that the command title is still easy to read and selecting the tile runs the expected command.

The trial also includes the earlier Option initial-cursor placement and Help-search mouse-click history improvements. Report any issue together with the tile or action that showed it. No diagnostic setup is required for this UI trial.
