# ~/.dotfiles/programs/sddm/sddm.nix
{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
       enable = true;
       wayland = {
         enable = true;
       };
       package = pkgs.kdePackages.sddm;
       extraPackages = with pkgs; [
         kdePackages.qtsvg
         kdePackages.qtmultimedia
         kdePackages.qtvirtualkeyboard
         sddm-astronaut
       ];
       theme = "sddm-astronaut-theme";
  };
  # #services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.theme = "40k_hacker";

  # # Copy local theme to /etc for SDDM to find it
  # environment.etc."sddm/themes/40k_hacker".source = ./themes/40k_hacker;

  # # Qt5 dependencies needed for QML themes to render correctly
  # environment.systemPackages = with pkgs; [
  #   libsForQt5.qt5.qtquickcontrols2
  #   libsForQt5.qt5.qtgraphicaleffects
  #   libsForQt5.qt5.qtsvg
  # ];

  #  services.displayManager.sddm = {
  #      enable = true;
  #      wayland.enable = true;
  #   #   theme = "sddm-theme-astronaut";
  #      package = pkgs.kdePackages.sddm;
  #      extraPackages = [
  #        pkgs.kdePackages.qt5compat
  #      ];
  #    };

  # # Optional: any SDDM extra settings
  # services.displayManager.sddm.settings = {
  #   General = {
  #     SessionCommand = "/etc/sddm/Xsession";
  #     InputMethod = "";
  #   };
  # };
}
