{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.homeDirectory = "/Users/origami";

  imports = [
    ../modules/common.nix
    ../modules/shell.nix
    ../modules/shell-develop.nix
    ../modules/zsh.nix
    ../modules/llm.nix
    ../modules/ssh.nix
    ../modules/nix-config.nix
    ../modules/atuin.nix
    ../modules/git.nix
    ../modules/direnv.nix
  ];

  programs.zsh.shellAliases = {
    "hm-update" = "home-manager switch --flake ${config.home.homeDirectory}/flakes#origami@hypnos";
    "brew" = "/opt/homebrew/bin/brew";
    "tailscale" = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
  };
  # 外壳同款配色
  programs.zsh.initContent = "zstyle ':prompt:grml:*:items:user' pre '%F{#82C8E5}'";

  # 虽然有些邪恶, 但是有些应用必须用 brew 装更新才够快
  programs.zsh.sessionVariables = {
    PATH = "/opt/homebrew/bin:\$PATH";
    TERM = "xterm-256color";
  };

  # 包
  home.packages = (
    with pkgs;
    [
      # 标准 GNU 工具
      autoconf
      coreutils
      gawk
      gnused
      gnutar
      gnugrep
      gnumake
      pkgconf
      unar
      tree
      xz
      pigz

      # 命令行小工具
      helix
      uv
      typst
      pandoc
      rsync

      # NixOS
      nix-output-monitor
      nixd
      nixfmt
      nixpkgs-fmt
      nix-index
      nix-tree
      sops
      age

      # 其他软件开发包
      rustup
      fnm
      opam
      graphviz
    ]
  );
}
