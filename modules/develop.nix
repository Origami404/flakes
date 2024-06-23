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

  programs.direnv.enable = true;
  programs.fish.shellInit = ''
    direnv hook fish | source
  '';

  programs.vscode.enable = true;
}
