{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    clang-tools
    python312
    python312Packages.ipython
  ];
  programs.fish.shellAliases = {
    "ipy" = "ipython --no-confirm-exit";
  };

  programs.vscode.enable = true;
}
