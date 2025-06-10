# Info


### System:
- Hyprland
- NixOS
- Waybar
- Rofi-wayland
- Thinkpad T480

I use pywall for themeing my system. The terminal and waybar are the only things that pull colors from it's cache though. I did not want things changing too much with the wallpapers.

Clicking on the gallery icon in the waybar opens a rofi window where you can select an image from the defined wallpaper folder. It is powered by Hyprpaper. The colors change immediately along with the wallpaper. (probably wont upload my wallpapers folder as some are slightly sketch and this profile is public lol)
![wallpaper picker](/assets/nitch.png)

I used cmus for my music playing needs. I got the config from a random redditor a while back. I will add a link to the post if i can ever find it again.
![cmus display](/assets/cmus.png)

This is my rofi launcher.
![rofi launcher](/assets/rofi.png)

>I do not use home manager. I am happy with my hierarchy at the moment and dont plan on implementing it anytime soon.

>The contents of ~/.config that i care about are periodically backed up to /z_backups.

>Any programs that i have configured via nix are contained inside the /programs directory.



I have a near endless todo list that i have set aside for now so that i can achieve some semblance of productivity, but here are some of the main things i need to get around to when i have a surplus of time:

- theme rofi windows with pywal (power menu and wallpicker)
- i *think* there is a bug with the waybar tray module when mullvad is connected...
- theme dolphin and/or switch to thunar
- get the nm-applet css working properly
- make sure the laptop battery dies gracefully
- implement some sort of fan control software
- cpu undervolting when off charger
- fcitx5 setup for typing in chinese. (bind to f11 key?)
- change the settings button / f9 to run "code ~/.dotfiles"
- color palette previews inside the wallpicker rofi menu? i think this isnt possible with rofi
- controller / bluetooth support
- change pgup/pgdn into media skip/replay binds
- setup shells for development and cyber
    - kali packages shell
    - rust shell
    - python shell
    - flutter shell