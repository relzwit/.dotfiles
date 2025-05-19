#!/usr/bin/env bash

#initializing wallpaper daemon
swww init &
#setting wallpaper
swww img /home/relz/Documents/wallpapers/catgirl.jpg &

# might need to add pkgs.networkmanagerapplet?
nm-applet --indicator &

#THE BARR
waybar &

#dunst
dunst
