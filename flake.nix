{
  description = "Origami404's NixOS Flake";

  inputs = {
    nixpkgs-linux.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-linux";
    };
    home-manager-darwin = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs-linux, nixpkgs-darwin, home-manager, home-manager-darwin, ... }@inputs: {
    nixosConfigurations = {
      "eris" = nixpkgs-linux.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/eris/configuration.nix
        ];
      };
    };

    darwinConfigurations = {
      "hypnos" = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hypnos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "origami@eris" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-linux.legacyPackages.x86_64-linux;
        modules = [
          { nixpkgs.config.allowUnfreePredicate = _: true; }
          inputs.sops-nix.homeManagerModules.sops
          ./home/hosts/eris.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          lib = import ./home/lib/origami404.nix {
            hmSource = inputs.home-manager;
            npLib = nixpkgs-linux.lib;
          };
        };
      };

      "origami@metis" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-linux.legacyPackages.x86_64-linux;
        modules = [
          { nixpkgs.config.allowUnfreePredicate = _: true; }
          inputs.sops-nix.homeManagerModules.sops
          ./home/hosts/metis.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          lib = import ./home/lib/origami404.nix {
            hmSource = inputs.home-manager;
            npLib = nixpkgs-linux.lib;
          };
        };
      };

      "origami@hypnos" = home-manager-darwin.lib.homeManagerConfiguration {
        pkgs = nixpkgs-darwin.legacyPackages.aarch64-darwin;
        modules = [
          { nixpkgs.config.allowUnfreePredicate = _: true; }
          inputs.sops-nix.homeManagerModules.sops
          ./home/hosts/hypnos.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
          lib = import ./home/lib/origami404.nix {
            hmSource = inputs.home-manager-darwin;
            npLib = nixpkgs-darwin.lib;
          };
        };
      };
    };
  };
}
