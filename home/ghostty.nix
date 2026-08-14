{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      font-family = "CaskaydiaCove Nerd Font";
      font-size = 12;
      theme = "ghostty-catppuccin-mocha";
    };
  };

  xdg.configFile."ghostty/themes/ghostty-catppuccin-mocha".source = ./ghostty/themes/ghostty-catppuccin-mocha;
}