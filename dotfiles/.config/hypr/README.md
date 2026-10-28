# Hyprland translation of the Niri setup

`hyprland.lua` targets the installed Hyprland 0.56.2 and uses its native scrolling
layout. It translates `../niri/config.kdl` and the DMS files that config includes.
It preserves the two monitor modes/positions/scales, keyboard layout, compose key,
Num Lock, cursor size, touchpad scrolling, DMS colors, gaps, rounded corners,
application rules, application shortcuts, media controls and most navigation binds.

Deploy this directory as `~/.config/hypr` with your dotfiles workflow, then select
Hyprland at login. Alternatively, start it with an explicit config path:

```sh
Hyprland --config /home/roope/Configuraatiot/dotfiles/.config/hypr/hyprland.lua
```

DMS must be running in the Hyprland session for its IPC shortcuts, panels, lock
screen and wallpaper to work. `config/autostart.lua` contains an optional DMS startup line
if your session does not already launch it. This translation is a snapshot: DMS
updates to the Niri KDL files will not update the Lua config automatically.

## File organization

- `hyprland.lua`: entry point; loads the files below relative to its own location.
- `config/`: environment, monitors, layout, input, appearance, animations,
  autostart, and application rules, each in its own Lua file.
- `bindings/`: application/DMS shortcuts, media keys, workspaces, monitors,
  window operations, screenshots, session controls, and window switching.
  `unsupported.lua` documents the Niri shortcuts without equivalents.
- `screenshot.sh`: screenshot capture and clipboard helper.

Edit the file for the relevant topic. Includes use `dofile` so every file is
executed again when Hyprland reloads its configuration.

## Differences

- Hyprland's scrolling layout approximates Niri; it does not reproduce all its
  behavior. Column centering uses `fit active`; centering visible columns uses
  `fit visible`, which can resize them. Maximize uses Hyprland's maximized mode.
- Moving a column to another workspace or monitor moves the focused window.
  Other windows stacked in the column stay behind. Relative workspace navigation
  uses Hyprland's monitor-local workspace order; numbered workspaces are global.
- Alt+Tab and Alt+grave cycle output windows (all apps or the current app).
  They do not reproduce Niri's graphical MRU switcher or recent-focus order.
- Niri's overview, hotkey overlay, workspace reordering, first/last column commands,
  and preset/reset window heights are left unbound. Their original keys are listed
  in `bindings/unsupported.lua`. No overview plugin is required or installed.
- Super+Escape toggles whether applications may inhibit compositor shortcuts;
  Hyprland handles shortcut inhibition differently from Niri.
- Hyprland borders approximate Niri's focus ring. Spring animations and opening/
  closing curves are approximations. Shadows remain disabled, matching Niri's
  shadow block without `on`. Niri's WezTerm sizing workaround and
  `place-within-backdrop` layer rules have no direct translation.
- The commented eDP-2 output remains inactive. `dms/input.kdl` and `dms/wpblur.kdl`
  are not included by the original config, so they are not imported here.

## Screenshots

Requires `grim`, `jq`, `wl-copy` (wl-clipboard), and `satty`; region selection also
requires `slurp` (not installed when this config was generated).

- Print: focused monitor, edited in Satty, then saved and copied.
- Alt+Print / Alt+XF86Launch1: active window.
- Ctrl+Print / Ctrl+XF86Launch1: focused monitor.
- XF86Launch1: region selection.

Saved captures use `~/Pictures/Screenshots/Screenshot from YYYY-MM-DD HH-MM-SS.png`.
The helper is invoked through Bash and does not need executable permissions.

## Validation

```sh
Hyprland --verify-config --config "$PWD/dotfiles/.config/hypr/hyprland.lua"
bash -n dotfiles/.config/hypr/screenshot.sh
```

Both pass with Hyprland 0.56.2. Interactive behavior, DMS integration and monitor
availability must be checked after logging into Hyprland.

References: [scrolling layout](https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/),
[dispatchers](https://wiki.hypr.land/configuring/core/dispatchers/),
[window rules](https://wiki.hypr.land/configuring/core/rules/window-rules/).
