{ config, pkgs, ... }:

{
  xdg.dataFile."themes".source = ./themes;
  xdg.configFile."quickshell/defaults.json".source = ./quickshell/defaults.json;
  xdg.configFile."quickshell/main".source = ./quickshell/main;
}