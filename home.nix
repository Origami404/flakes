{ config, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "origami";
    userEmail = "Origami404@foxmail.com";
  };

  home.packages = with pkgs;[];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };

  home.stateVersion = "23.11";

}
