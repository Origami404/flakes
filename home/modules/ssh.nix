{ config, lib, ... }:
{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/ssh-config.yaml;
  };

  home.file.".ssh" = {
    source = ./ssh;
    recursive = true;
  };

  home.activation.sshDirPerms = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.ssh" ]; then
      chmod 700 "$HOME/.ssh"
    fi
  '';

  sops.secrets."ssh-config" = {
    path = "${config.home.homeDirectory}/.ssh/config";
    mode = "600";
  };
  sops.secrets."ssh-private" = {
    sopsFile = ../../secrets/ssh-private.yaml;
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "600";
  };

}
