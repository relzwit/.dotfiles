# ~/.dotfiles/programs/sddm/sddm.nix
{ config, pkgs, ... }:

{
  # Enable the SDDM display manager
  services.displayManager.sddm.enable = true;

  # Set the theme
  services.displayManager.sddm.theme = "40k_hacker";

  # Let SDDM know where to find the theme (point to your .dotfiles/programs/sddm/themes directory)
  environment.systemPackages = [
    pkgs.libsForQt5.qt5.qtquickcontrols2  # needed for some QML themes
  ];

  # Copy the local theme directory into /etc
  # This way, SDDM finds it at /etc/sddm/themes/40k_hacker
  environment.etc."sddm/themes/40k_hacker".source = 
    ./themes/40k_hacker;

  # Optional: extra config
  services.displayManager.sddm.settings = {
    General = {
      # (Optional) Set default session
      SessionCommand = "/etc/sddm/Xsession";
      # (Optional) Specify user icon theme
      InputMethod = "";
    };
  };
}
