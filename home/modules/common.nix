{ config, lib, pkgs, ... }:
{
  home.username = "origami";

  programs.home-manager.enable = true;

  programs.nix-index.enable = true;

  home.stateVersion = "23.11";
}
