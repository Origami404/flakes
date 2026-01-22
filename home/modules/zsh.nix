{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };
  home.shell.enableZshIntegration = true;

  home.file =
    (lib.origami404.standaloneToHome ".zsh.d")
    // (lib.origami404.standaloneToHome { rel = ".zshrc"; realpath = ".zshrc.o4"; });
  programs.zsh.initContent = "source $HOME/.zshrc.o4";
}
