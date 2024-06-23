{ config, lib, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  imports = [
    (import ./modules/shell.nix)
    (import ./modules/desktop.nix)
    (import ./modules/develop.nix)
    (import ./modules/gnome-dconf.nix)
  ];

  home.packages = with pkgs;[
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];
  programs.nix-index.enable = true;

  home.stateVersion = "23.11";
}
