{ config, lib, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  imports = [
    (import ./modules/shell.nix)
    (import ./modules/shell-develop.nix)
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;
  home.stateVersion = "23.11";
}
