#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
MONITOR="DP-1"  # Change to your monitor name

RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
hyprctl hyprpaper preload "$RANDOM_WALLPAPER"
hyprctl hyprpaper wallpaper "$MONITOR,$RANDOM_WALLPAPER"
