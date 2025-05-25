{
  description = "My NixOS flake-based config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    #nixvim.url = "github:nix-community/nixvim/nixos-24.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      #hostname
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}

