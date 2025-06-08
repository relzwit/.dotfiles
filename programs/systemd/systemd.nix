{ config, pkgs, lib, ... }:

let
  swapUUID = "2e378d8c-48ab-4c5d-93f6-ae7578b433b9";
in
{
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/${swapUUID}";
    }
  ];

  boot = {
    resumeDevice = "/dev/disk/by-uuid/${swapUUID}";
    kernelParams = [ "resume=/dev/disk/by-uuid/${swapUUID}" ];

    # REMOVE this line since 'resume' module does not exist
    # initrd.kernelModules = [ "resume" ];
  };

  services.logind = {
    extraConfig = lib.mkForce ''
      HandleSuspendKey=suspend
      HandleHibernateKey=hibernate
      IdleAction=ignore
    '';
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=600
    HibernateMode=platform shutdown
  '';
}
