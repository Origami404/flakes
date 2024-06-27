{ pkgs, lib, config, ... }:
{
  programs.gnupg = {
    enable = true;
    agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}