{ pkgs, lib, config, ... }:
{
  programs.direnv.enable = true;
  programs.direnv.config = {
    global = {
      load_dotenv = true;
      strict_env = true;
    };
  };
}
