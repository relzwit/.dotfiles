{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };

  # For fingerprint authentication in GDM
  security.pam.services.gdm-fingerprint = {
    text = ''
      auth       sufficient   pam_fprintd.so
      auth       include      gdm
    '';
  };

  # Enable GNOME Keyring (for secrets management)
  services.gnome.gnome-keyring.enable = true;
}

