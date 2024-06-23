# Generated via dconf2nix: https://github.com/nix-commmunity/dconf2nix
{ lib, ... }:
with lib.hm.gvariant;
{
  dconf = {
    enable = true;
    settings = {
      # UI 和字体
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
        titlebar-font = "LXGW WenKai 13";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        document-font-name = "LXGW WenKai Mono 12";
        font-antialiasing = "rgba";
        font-hinting = "slight";
        font-name = "LXGW WenKai 12";
        gtk-theme = "Adwaita-dark";
        monospace-font-name = "CaskaydiaCove Nerd Font Propo Semi-Light 12";
        show-battery-percentage = true;
        text-scaling-factor = mkDouble "1.25";
        toolkit-accessibility = false;
      };

      # 输入法
      "org/gnome/desktop/input-sources" = {
        current = mkUint32 0;
        mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
        per-window = false;
        show-all-sources = true;
        sources = [ (mkTuple [ "xkb" "us" ]) ];
        xkb-options = [ "lv3:ralt_switch" "caps:super" ];
      };

      # 键盘鼠标触控板
      "org/gnome/desktop/peripherals/keyboard" = {
        numlock-state = false;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        edge-scrolling-enabled = false;
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      # 快捷键
      "org/gnome/desktop/wm/keybindings" = {
        cycle-group = [ ];
        cycle-group-backward = [ ];
        cycle-panels = [ ];
        cycle-panels-backward = [ ];
        cycle-windows = [ ];
        cycle-windows-backward = [ ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        move-to-workspace-5 = [ "<Super><Shift>5" ];
        move-to-workspace-down = [ "<Super><Shift>Page_Down" ];
        move-to-workspace-last = [ ];
        move-to-workspace-left = [ "<Shift><Super>Left" ];
        move-to-workspace-right = [ "<Shift><Super>Right" ];
        move-to-workspace-up = [ "<Super><Shift>Page_Up" ];
        panel-run-dialog = [ ];
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-group = [ ];
        switch-group-backward = [ ];
        switch-input-source = [ "<Control>space" ];
        switch-input-source-backward = [ "<Shift><Control>space" ];
        switch-panels = [ ];
        switch-panels-backward = [ ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-5 = [ "<Super>5" ];
        switch-to-workspace-last = [ ];
        switch-to-workspace-left = [ "<Super>Left" ];
        switch-to-workspace-right = [ "<Super>Right" ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kgx";
        name = "Run terminal";
      };
      "org/gnome/mutter" = {
        overlay-key = "Super_L";
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ "<Alt><Super>Left" ];
        toggle-tiled-right = [ "<Alt><Super>Right" ];
      };
      "org/gnome/shell/keybindings" = {
        screenshot = [ ];
        screenshot-window = [ ];
        show-screen-recording-ui = [ ];
        show-screenshot-ui = [ "<Shift><Super>s" ];
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        toggle-application-view = [ ];
      };
      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      # 登录和休眠
      "org/gnome/login-screen" = {
        enable-fingerprint-authentication = true;
        enable-password-authentication = true;
        enable-smartcard-authentication = false;
      };
      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = false;
        sleep-inactive-ac-type = "nothing";
      };

      # 截图自动保存
      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        lock-delay = mkUint32 60;
        lock-enabled = true;
        picture-options = "zoom";
        primary-color = "#241f31";
        secondary-color = "#000000";
      };

      # 文件管理器
      "org/gnome/nautilus/compression" = {
        default-compression-format = "zip";
      };
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "extra-large";
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "icon-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      # 隐私
      "org/gnome/desktop/privacy" = {
        disable-camera = true;
        disable-microphone = true;
        old-files-age = mkUint32 7;
        recent-files-max-age = -1;
        remember-recent-files = false;
        remove-old-temp-files = true;
        report-technical-problems = false;
      };
      "org/gnome/system/location" = {
        enabled = false;
      };

      # 杂七杂八
      "org/gnome/desktop/search-providers" = {
        disable-external = true;
        sort-order = [ "org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
      };
      "org/gnome/desktop/session" = {
        idle-delay = mkUint32 0;
      };
      "org/gnome/desktop/sound" = {
        event-sounds = true;
      };
      "org/gnome/software" = {
        download-updates = false;
        download-updates-notify = false;
      };
      "org/gnome/tweaks" = {
        show-extensions-notice = false;
      };
    };
  };
}
