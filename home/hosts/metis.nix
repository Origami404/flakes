{ config, lib, pkgs, ... }:

{
  home.homeDirectory = "/home/origami";

  imports = [
    ../modules/common.nix
    ../modules/shell.nix
    ../modules/shell-develop.nix
  ];
}
