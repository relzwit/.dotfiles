{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  # Enable GDM as the display manager
  services.xserver.displayManager.gdm.enable = true;

  # Disable other display managers to avoid conflicts
  services.displayManager.sddm.enable = false;

  # Make sure both Plasma and Hyprland are available sessions
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable Hyprland session files so GDM can see it
  #probably better to do this inside the main file
  #programs.hyprland.enable = true;

  # Optional: If you want to explicitly set the default session to Hyprland
  # Note: GDM remembers the last session by default, but this can force it:
  #environment.variables = {
    # This env var may help some apps know you want Hyprland session by default
   # XDG_SESSION_DESKTOP = "hyprland";
  #};
}