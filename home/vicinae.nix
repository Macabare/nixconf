{ config, pkgs, ... }:

{
  xdg.configFile."vicinae/settings.json".source = ./vicinae/settings.json;
}