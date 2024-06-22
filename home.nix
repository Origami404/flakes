{ config, pkgs, ... }:

{
  home.username = "origami";
  home.homeDirectory = "/home/origami";

  programs.home-manager.enable = true;

  home.packages = with pkgs;[
    # Shell & Editor
    fish 

    # Archives
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
    btop # better top

    # Networking
    mtr # better traceroute
    iperf3
    q # better dig/nslookup
    socat # better netcat
    nmap

    # Misc
    grc
    neofetch

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Desktop Utils
    gnome3.gnome-tweaks
    telegram-desktop
  ];

  programs.fzf.enableFishIntegration = false; # use fish.fzf keybinding
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = with pkgs.fishPlugins; [
      { name = "z"; src = z.src; }
      { name = "grc"; src = grc.src; }
      { name = "fzf-fish"; src = fzf-fish.src; }
      { name = "autopair"; src = autopair.src; }
      { name = "colored-man-pages"; src = colored-man-pages.src; }
    ];
    shellInit = ''
      fzf_configure_bindings --directory=\cp --git_log=\cl --history=\cr \
        --git_status= --processes= --variables=
    '';
    shellAbbrs = {
      "..." = "../..";
      "...." = "../../..";
    };
    shellAliases = {
      "ls" = "eza";
      "ll" = "eza -l";
      "la" = "eza -a";
      "grep" = "rg";
      "top" = "btop";
      "dig" = "q";
      "find" = "fd";
      "du" = "dust";
      "df" = "duf";
      "cloc" = "scc";
      "cat" = "bat";
      "x" = "atool -x";
      "flake-update" = "nixos-rebuild switch --use-remote-sudo --flake /home/origami/flakes#um790-nix";
      "cl" = "clear";
    };
  };

  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "23.11";

}
