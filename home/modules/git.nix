{ lib, ... }:
{
  programs.git.enable = true;
  home.file =
    (lib.origami404.standaloneToHome ".gitconfig") // (lib.origami404.standaloneToHome ".gitignore");
}
