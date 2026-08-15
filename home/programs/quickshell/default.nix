{ config, pkgs, ... }:
{
  xdg.dataFile."themes".source = ./themes;
  xdg.configFile."quickshelldefaults.json".source = ./defaults.json;
  xdg.configFile."quickshell/main".source = ./main;
}