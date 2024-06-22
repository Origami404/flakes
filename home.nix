{ config, lib, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  imports = [
    (import ./modules/shell.nix)
  ];

  home.packages = with pkgs;[
    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Desktop Utils
    gnome3.gnome-tweaks
    telegram-desktop
    qq
  ];

  # An Apple Music client, only can be downloaded after purchasing
  xdg.desktopEntries = {
    Cider = {
      name = "Cider";
      exec = "appimage-run ${config.home.homeDirectory}/app/Cider-2.4.1.AppImage";
      terminal = false;
      categories = [ "Application" ];
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "23.11";

}
