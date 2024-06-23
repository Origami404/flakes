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

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Origami404";
    userEmail = "Origami404@foxmail.com";
    extraConfig = {
      user.signingKey = "5C7FCAFBC961E2E312B47FEC76447D4671CB3CC0";
      core.autocrlf = "input";
      push.autoSetupRemote = true;
      pull.rebase = true;
      init.defaultBranch = "main";
    };
    aliases = {
      "l" = "log --date-order --graph --pretty=\"format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset\"";
    };
  };

  programs.vscode.enable = true;
}
