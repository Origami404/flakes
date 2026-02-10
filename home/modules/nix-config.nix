{ config, lib, ... }:
let
  nixConfDir = "${config.home.homeDirectory}/.config/nix";
in
{
  home.activation.nixConfDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${nixConfDir}"
  '';

  sops.secrets."github-pat" = {
    sopsFile = ../../secrets/github.yaml;
  };

  sops.templates."nix.conf" = {
    path = "${nixConfDir}/nix.conf";
    mode = "600";
    content = ''
      access-tokens = github.com=${config.sops.placeholder."github-pat"}
    '';
  };
}
