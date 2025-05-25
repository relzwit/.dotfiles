{ config, pkgs, ... }:

let
  stylixConfigDir = "${config.home.homeDirectory}/.dotfiles/programs/stylix";
in

{
  environment.systemPackages = [
    pkgs.stylix
    pkgs.jq  # Stylix dependency
  ];

  # Optionally, add a systemd user service or a script wrapper here
}

