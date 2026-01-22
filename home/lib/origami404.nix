{ hmSource, npLib }:
let
  standaloneRoot = ../standalone;
  baseLib = import "${hmSource}/modules/lib/stdlib-extended.nix" npLib;
in
baseLib.extend (final: prev: {
  origami404 = (prev.origami404 or { }) // {
    standaloneToHome = arg:
      let
        rel = if prev.isString arg then arg else arg.rel;
        realpath = if prev.isString arg then rel else (arg.realpath or rel);
        src = standaloneRoot + "/${rel}";
        isDir = prev.filesystem.pathIsDirectory src;
      in
      {
        "${realpath}" = {
          source = src;
          recursive = isDir;
        };
      };
  };
})
