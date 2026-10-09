#!/usr/bin/env bash
set -euo pipefail

pictures_dir="$(xdg-user-dir PICTURES)"
screenshot_path="$pictures_dir/screenshot.png"
last_screenshot_path="$pictures_dir/last_screenshot.png"

mkdir -p "$pictures_dir"

# Find the focused output in niri
screen="$(niri msg --json focused-output | jq -r '.name')"

if [[ -z "$screen" ]]; then
    notify-send "Screenshot" "Could not determine the focused monitor"
    exit 1
fi

# Capture and open the screenshot in Satty
if ! grim -o "$screen" - | satty --filename - -o "$screenshot_path" --early-exit; then
    notify-send "Screenshot" "Canceled"
    exit 1
fi

# Preserve the previous screenshot, if one exists
if [[ -f "$screenshot_path" ]]; then
    cp "$screenshot_path" "$last_screenshot_path"
    wl-copy --type image/png < "$screenshot_path"
    notify-send "Screenshot" "Screenshot was copied to the clipboard!"
else
    notify-send "Screenshot" "Canceled"
    exit 1
fi
