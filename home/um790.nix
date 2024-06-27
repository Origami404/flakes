{ config, lib, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  imports = [
    (import ./modules/shell.nix)
    (import ./modules/desktop.nix)
    (import ./modules/shell-develop.nix)
    (import ./modules/vscode.nix)
    (import ./modules/gnome-dconf.nix)
  ];

  nixpkgs.config.allowUnfreePredicate = _: true;
  home.packages = with pkgs;[
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];
  programs.nix-index.enable = true;

  home.stateVersion = "23.11";
}
