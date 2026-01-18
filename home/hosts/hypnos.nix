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

  programs.zsh.shellAliases = {
    "hm-update" = "home-manager switch --flake ${config.home.homeDirectory}/flakes#origami@hypnos";
  };
  # 外壳同款配色
  programs.zsh.initContent = "zstyle ':prompt:grml:*:items:user' pre '%F{#82C8E5}'";
}
