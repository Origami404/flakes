{ config, lib, pkgs, ... }:

{
  home.homeDirectory = "/Users/origami";

  imports = [
    ../modules/common.nix
    ../modules/shell.nix
    ../modules/shell-develop.nix
    ../modules/zsh.nix
    ../modules/darwin-packages.nix
    ../modules/llm.nix
  ];

  programs.fish.shellAliases = {
    "flake-update" = "home-manager switch --flake ${config.home.homeDirectory}/flakes#origami@hypnos";
  };
}
