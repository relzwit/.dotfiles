{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.swaybg}/bin/swaybg -i ${config.stylix.image} -m fill && \
          ${pkgs.greetd.gtkgreet}/bin/gtkgreet \
            --layer-shell \
            --css ${./greeter-style.css} \
            --command Hyprland
        '';
        user = "greeter";
      };
    };
  };
  
  stylix.targets.greetd.enable = true;
}
