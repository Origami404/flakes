{ config, lib, pkgs, ... }:

{
  home.homeDirectory = "/home/origami";

  imports = [
    ../modules/common.nix
    ../modules/shell.nix
    ../modules/zsh.nix
    ../modules/desktop.nix
    ../modules/shell-develop.nix
    ../modules/vscode.nix
    ../modules/gnome-dconf.nix
    ../modules/ssh.nix
    ../modules/nix-config.nix
  ];

  home.packages = with pkgs;[
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
  ];

  programs.fish.shellAliases = {
    "flake-update" = "nixos-rebuild switch --use-remote-sudo --flake ${config.home.homeDirectory}/flakes#eris";
  };
}
