{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, stylix, ... }: {
    nixosConfigurations.yourhost = nixpkgs.lib.nixosSystem {
      modules = [
        stylix.nixosModules.stylix
        ({ config, pkgs, ... }: {
          services.greetd = {
            enable = true;
            settings = {
              default_session = {
                command = ''
                  ${pkgs.swaybg}/bin/swaybg -i ${stylix.image} -m fill && \
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
        })
      ];
    };
  };
}
