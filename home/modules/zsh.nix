{ lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "25.03.19";
          sha256 = "sha256-/6V6IHwB5p0GT1u5SAiUa20LjFDSrMo731jFBq/bnpw=";
        };
      }
    ];
  };
  home.file.".zshrc".source = ./zsh/.zshrc;
  home.file.".zsh.d" = {
    source = ./zsh/.zsh.d;
    recursive = true;
  };
}
