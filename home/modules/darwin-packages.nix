{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      autoconf
      coreutils
      gawk
      gnused
      gnutar
      gnugrep
      gnumake
      pkgconf
      unar

      codex

      helix
      uv
      typst
      pandoc
    ])
    ;
}
