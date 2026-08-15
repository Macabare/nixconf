{ config, pkgs, ... }:
{
  xdg.configFile."hypr/conf".source = ./conf;
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
}