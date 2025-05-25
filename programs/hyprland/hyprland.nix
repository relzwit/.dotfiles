{ config, pkgs, ... }:

let
  # User name, replace "relz" with your actual username or pass via module option
  username = "relz";

  # Paths
  dotfilesHyprland = "/home/${username}/.dotfiles/programs/hyprland";
  hyprConfigDir = "/home/${username}/.config/hypr";

in {
  options.hyprland.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hyprland with dotfiles config symlink";
  };

  config = lib.mkIf config.hyprland.enable {
    # Enable hyprland (programs.hyprland is from nixpkgs)
    programs.hyprland.enable = true;

    # Symlink ~/.config/hypr to ~/.dotfiles/programs/hyprland
    environment.etc."home/${username}/.config/hypr".source = dotfilesHyprland;

    # Make sure start.sh and rand-wall.sh are executable
    # You can do this outside nix in dotfiles or here by a systemd tmpfiles rule
    systemd.tmpfiles.rules = [
      "f ${dotfilesHyprland}/start.sh 0755 ${username} ${username} - -"
      "f ${dotfilesHyprland}/rand-wall.sh 0755 ${username} ${username} - -"
    ];

    # Optionally set XDG_CONFIG_HOME so apps launched in hyprland session respect dotfiles/programs
    # This is useful if you launch other XDG apps here
    environment.sessionVariables = {
      XDG_CONFIG_HOME = "/home/${username}/.dotfiles/programs";
    };
  };
}

