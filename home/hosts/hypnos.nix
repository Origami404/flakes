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
    ../modules/atuin.nix
    ../modules/git.nix
  ];

  programs.zsh.shellAliases = {
    "hm-update" = "home-manager switch --flake ${config.home.homeDirectory}/flakes#origami@hypnos";
  };
  # 外壳同款配色
  programs.zsh.initContent = "zstyle ':prompt:grml:*:items:user' pre '%F{#82C8E5}'";

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

      # 命令行小工具
      helix
      uv
      typst
      pandoc

      # NixOS
      nix-output-monitor
      nixd
      nixfmt
      nixpkgs-fmt
      nix-index
      nix-tree
    ]
  );
}
