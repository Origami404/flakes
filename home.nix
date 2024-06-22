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
    neofetch


    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Desktop Utils
    gnome3.gnome-tweaks
    telegram-desktop
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = with pkgs.fishPlugins; [
      { name = "z"; src = z.src; }
      { name = "grc"; src = grc.src; }
      { name = "fzf"; src = fzf.src; }
    ];
  };

  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "23.11";

}
