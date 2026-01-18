{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  home.shell.enableZshIntegration = true;

  home.file.".zsh.d" = {
    source = ./zsh/.zsh.d;
    recursive = true;
  };
  home.file.".zshrc.o4".source = ./zsh/.zshrc;
  programs.zsh.initContent = "source $HOME/.zshrc.o4";
}
