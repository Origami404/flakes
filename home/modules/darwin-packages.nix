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

      # localsend

      # zotero
      # logseq
      # telegram-desktop

      # unnaturalscrollwheels

      # noto-fonts-cjk-sans
      # sarasa-gothic
      # source-code-pro
    ])
    ;
}
