{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    lldb
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

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Origami404";
        email = "Origami404@foxmail.com";
        signingKey = "5C7FCAFBC961E2E312B47FEC76447D4671CB3CC0";
      };
      core.autocrlf = "input";
      push.autoSetupRemote = true;
      pull.rebase = true;
      init.defaultBranch = "main";
      aliases = {
        "l" = "log --date-order --graph --pretty=\"format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset\"";
      };
    };
  };
}
