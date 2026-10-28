#!/usr/bin/env bash
# Hyprland counterpart of screenshotniri.sh; invoked explicitly through bash.
set -euo pipefail
mode=${1:-annotate}
directory="$HOME/Pictures/Screenshots"
mkdir -p "$directory"
file="$directory/Screenshot from $(date '+%Y-%m-%d %H-%M-%S').png"
case "$mode" in
    window)
        geometry=$(hyprctl -j activewindow | jq -er 'select(.address != "0x") | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$geometry" "$file"
        ;;
    region)
        geometry=$(slurp)
        grim -g "$geometry" "$file"
        ;;
    screen|annotate)
        output=$(hyprctl -j monitors | jq -er '.[] | select(.focused) | .name')
        if [[ "$mode" == annotate ]]; then
            grim -o "$output" - | satty --filename - --output-filename "$file"
        else
            grim -o "$output" "$file"
        fi
        ;;
    *) exit 2 ;;
esac
if [[ -f "$file" ]]; then
    wl-copy --type image/png < "$file"
fi
