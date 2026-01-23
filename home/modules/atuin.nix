{ lib, ... }:
{
  programs.atuin = {
    enable = true;
    # 我自己会写 zshrc 集成的部分，所以关掉自动集成
    enableZshIntegration = false;
  };

  home.file =
    (lib.origami404.standaloneToHome ".config/atuin");
}
