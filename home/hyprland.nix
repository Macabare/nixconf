{ config, pkgs, ... }:
{
  xdg.configFile."hypr/conf".source = ./hyprland/conf;
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland/hyprland.lua;
}