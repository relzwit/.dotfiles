{ config, lib, pkgs, ... }:

{
  options = { };

  config = {
    # Needed KDE and XDG packages
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.kio
      xdg-utils
      shared-mime-info
    ];

    # Set XDG_MENU_PREFIX globally
    environment.sessionVariables = {
      XDG_MENU_PREFIX = "nixos-";
      XDG_DATA_DIRS = lib.mkForce "/run/current-system/sw/share:/etc/profiles/per-user/$USER/share";
    };

    # Create the applications.menu file for kbuildsycoca6
    environment.etc."xdg/menus/applications.menu".text = ''
      <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
                            "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">
      <Menu>
          <Name>Applications</Name>
          <DefaultAppDirs/>
          <DefaultDirectoryDirs/>
          <Include>
              <All/>
          </Include>
      </Menu>
    '';

    # User systemd service to rebuild KDE system config database at login
    systemd.user.services.kbuildsycoca6-refresh = {
      description = "Rebuild KDE system configuration cache";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.kdePackages.kinit}/bin/kbuildsycoca6";
        Environment = "XDG_MENU_PREFIX=nixos-";
      };
    };
  };
}
