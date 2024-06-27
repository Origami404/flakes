{
  description = "Origami404's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "um790-nix" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "origami@um790-nix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home/um790.nix ];
        extraSpecialArgs = { inherit inputs; };
      };

      "origami@metis" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./home/metis.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
  };
}

