{ config, lib, pkgs, ... }:

let
  redshiftScript = pkgs.writeShellScript "redshift-toggle" ''
    #!/usr/bin/env bash

    while true; do
      hour=$(date +%H)
      if (( hour >= 17 || hour < 2 )); then
        echo "Turning on Redshift at $(date)"
        ${pkgs.redshift}/bin/redshift -O 3500
      else
        echo "Turning off Redshift at $(date)"
        ${pkgs.redshift}/bin/redshift -x
      fi
      sleep 300
    done
  '';
in
{
  environment.systemPackages = with pkgs; [ redshift ];

  programs.redshift = {
    enable = true;
    temperature.day = 5500;
    temperature.night = 3500;
    latitude = "auto";
    longitude = "auto";
  };

  systemd.user.services.redshift-toggle = {
    description = "User-level Toggle Redshift based on time";
    script = redshiftScript;
    serviceConfig = {
      Restart = "always";
      RestartSec = "10";
    };
    wantedBy = [ "default.target" ];  # starts when you log in
  };
}

