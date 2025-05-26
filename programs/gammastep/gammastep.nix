{ config, lib, pkgs, ... }:

let
  gammastepScript = pkgs.writeShellScript "gammastep-toggle" ''
    #!/usr/bin/env bash

    while true; do
      hour=$(date +%H)
      if (( hour >= 17 || hour < 2 )); then
        echo "Turning on gammastep at $(date)"
        pkill gammastep
        ${pkgs.gammastep}/bin/gammastep -O 3500 &
      else
        echo "Turning off gammastep at $(date)"
        pkill gammastep
      fi
      sleep 30
    done
  '';
in
{
  environment.systemPackages = with pkgs; [ gammastep ];

  systemd.user.services.gammastep-toggle = {
    description = "User-level Toggle gammastep based on time";
    serviceConfig = {
      ExecStart = "${gammastepScript}";
      Restart = "always";
      RestartSec = "10";
    };
    wantedBy = [ "default.target" ];
  };
}

