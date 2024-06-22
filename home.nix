{ config, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  home.packages = with pkgs;[ ];
  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "23.11";

}
