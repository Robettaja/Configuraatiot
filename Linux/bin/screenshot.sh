#!/usr/bin/env bash

screenshot_path="$(xdg-user-dir PICTURES)/screenshot.png"
last_screenshot_path="$(xdg-user-dir PICTURES)/last_screenshot.png"

screen="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"

mv "$screenshot_path" "$last_screenshot_path"

if ! grim -o "$screen" - | satty --filename - -o "$screenshot_path"; then
    notify-send "Screenshot" "Canceled"
    exit 1
fi

if [ -z "$screenshot_path" ]; then
    notify-send "Screenshot" "Canceled"
    exit 1
fi

cat "$screenshot_path" | wl-copy -n

notify-send "Screenshot" "Screenshot was copied to the clipboard!"
