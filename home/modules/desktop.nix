{ pkgs, lib, config, ... }:
{

  # This can update  XDG_DATA_DIR in .profile, which 
  # make applications show up in GNOME's application menu.
  # See: https://github.com/nix-community/home-manager/issues/1439#issuecomment-673944201
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;
  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = "${pkgs.desktop-file-utils}/bin/update-desktop-database";
    };
  };

  home.packages = with pkgs; [
    desktop-file-utils

    telegram-desktop
    qq
    mpv
    feishu
    moonlight-qt
    virt-manager
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