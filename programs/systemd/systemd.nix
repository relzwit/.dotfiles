{ config, pkgs, ... }:

{
  ####### Swap & Hibernate Settings ########

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/2e378d8c-48ab-4c5d-93f6-ae7578b433b9";
    }
  ];

  # For hibernate support: resume device
  boot.resumeDevice = "/dev/disk/by-uuid/2e378d8c-48ab-4c5d-93f6-ae7578b433b9";
  boot.kernelParams = [
    "resume=/dev/disk/by-uuid/2e378d8c-48ab-4c5d-93f6-ae7578b433b9"
  ];

  ####### systemd-logind Power Config ########

  services.logind.extraConfig = ''
    HandleSuspendKey=suspend
    HandleHibernateKey=hibernate
    IdleAction=ignore
    HibernateDelaySec=600
    HibernateMode=platform
  '';

  ####### Optional: powertop auto-tune (only if you want it) ########

  # services.powertop.enable = true;
}

