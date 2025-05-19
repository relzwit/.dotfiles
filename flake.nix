{

  description = "first flake i guess";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix/release-24.11";
    # helix editor
    helix.url = "github:helix-editor/helix/master";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	inputs.stylix.nixosModules.stylix
      ];
    };
  };

}
