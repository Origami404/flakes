{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    desktop-file-utils

    telegram-desktop
    qq
    mpv
    feishu
    moonlight-qt
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
}