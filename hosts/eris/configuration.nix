# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
      configurationLimit = 10;
    };
  };

  networking.hostName = "eris";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    trusted-users = [ "origami" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl

    # Archives
    zip
    xz
    unzip
    p7zip
    zstd
    gnutar

    # Misc
    file
    which
    tree
    gnused # sed
    gawk # awk
    gnupg
    pciutils # lspci
    usbutils # lsusb
    v2raya # Only for Chinese user

    # Nix related
    home-manager
    nix-output-monitor
    nixd
    nix-index
    nix-tree

    # Desktop Utils
    gnome3.gnome-tweaks
    chromium # Web browser
    appimage-run
  ];

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      lxgw-wenkai
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = [ "Noto Serif CJK SC Regular" "Noto Serif" ];
      sansSerif = [ "Noto Sans CJK SC Regular" "Noto Sans" ];
      monospace = [ "CaskaydiaCove Nerd" ];
    };
  };

  i18n = {
    defaultLocale = "C.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
      LC_TIME = "C.UTF-8";
      LC_CTYPE = "zh_CN.UTF-8";
    };
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-nord
      ];
    };
  };

  #programs.hyprland.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-connections
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-clocks
    gnome-weather
    gnome-contacts
    simple-scan
  ]);

  virtualisation.libvirtd.enable = true;
  services.tailscale.enable = true;

  # Users
  programs.fish.enable = true;
  users.groups.origami.gid = 1000;
  users.users.origami = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Origami404";
    group = "origami";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZxRoweHoLfoaydPqhsLnc4EGgwTp7Uz1DZ2DG447B+ origami@fedora"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  sops.defaultSopsFile = ../../secrets/ssh-private.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/origami/.config/sops/age/keys.txt";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "23.11";
}
