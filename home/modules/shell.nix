{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    atool # all-in-one tar
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
    scc # better cloc
    btop # better top
    grc # log file colorize
    neofetch # tool for showing off 
    mtr       # better traceroute
    iperf3    
    q         # better dig/nslookup
    socat     # better netcat
    nmap 
  ];

  programs.nix-index.enableFishIntegration = true;
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
      "nc" = "socat";
      "netcat" = "socat";
      "find" = "fd";
      "du" = "dust";
      "df" = "duf";
      "cloc" = "scc";
      "cat" = "bat";
      "x" = "atool -x";
      "flake-update" = "nixos-rebuild switch --use-remote-sudo --flake ${config.home.homeDirectory}/flakes#eris";
      "cl" = "clear";
    };
  };
}
