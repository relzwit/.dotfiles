{
  description = "My NixOS flake-based config";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixos-06cb-009a-fingerprint-sensor = {
    #   url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #nixvim.url = "github:nix-community/nixvim/nixos-24.11";
  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, ... }: {
    #nixos-06cb-009a-fingerprint-sensor,
    nixosConfigurations = {
      #hostname
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          nixos-hardware.nixosModules.lenovo-thinkpad-t480
        ];
      };
    };
  };
}

