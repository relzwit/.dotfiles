#!/usr/bin/env bash

hyprpaper &

/home/relz/.config/hypr/scripts/rand-wall.sh &

# might need to add pkgs.networkmanagerapplet?
nm-applet --indicator &

#THE BARR
waybar &

#dunst
dunst
