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
    };
  };

  networking.hostName = "um790-nix";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    trusted-users = [ "origami" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl

    # Shell & Editor
    fish # better shell
    #helix.packages."${pkgs.system}".helix

    # Archives
    zip
    xz
    unzip
    p7zip
    zstd
    gnutar
    atool # all-in-one tar

    # Modern unix
    ripgrep # better grep
    jq # better cat on json
    bat # better cat on everything
    eza # better ls
    fzf # A command-line fuzzy finder
    du-dust # better du
    duf # better df
    fd # better find
    btop # better top
    procs # better ps
    zoxide # better cd
    scc # better cloc

    # Networking
    mtr # better traceroute
    iperf3
    q # better dig/nslookup
    socat # better netcat
    nmap

    # Misc
    file
    which
    tree
    gnused # sed
    gawk # awk
    gnupg
    pciutils # lspci
    usbutils # lsusb
    neofetch
    v2raya # Only for Chinese user

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    nixd
    nixpkgs-fmt

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Desktop Utils
    chromium # Web browser
    gnome3.gnome-tweaks
  ];

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      lxgw-wenkai
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
    ];
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      serif = [ "Noto Serif CJK SC Bold" "Noto Serif" ];
      sansSerif = [ "Noto Sans CJK SC Bold" "Noto Sans" ];
      monospace = [ "CaskaydiaCove Nerd" ];
      emoji = [ "Noto Color Emoji" ];
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
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/origami/.config/sops/age/keys.txt";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];
}


