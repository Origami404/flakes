{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager-darwin.darwinModules.home-manager
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "hypnos";
  time.timeZone = "Asia/Shanghai";

  programs.fish.enable = true;

  users.users.origami = {
    home = "/Users/origami";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
    extraSpecialArgs = {
      lib = import ../../home/lib/origami404.nix {
        hmSource = inputs.home-manager-darwin;
        npLib = inputs.nixpkgs-darwin.lib;
      };
    };
    users.origami = import ../../home/hosts/hypnos.nix;
  };

  environment.systemPackages = with pkgs; [ home-manager ];

  nixpkgs.config.allowUnfreePredicate = _: true;

  system.stateVersion = 5;
}
