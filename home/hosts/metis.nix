{ config, lib, pkgs, ... }:

{
  home.homeDirectory = "/home/origami";

  imports = [
    ../modules/common.nix
    ../modules/shell.nix
    ../modules/zsh.nix
    ../modules/shell-develop.nix
    ../modules/ssh.nix
  ];
}
