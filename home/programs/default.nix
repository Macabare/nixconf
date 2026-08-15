{ pkgs, inputs, ... }:
{
  imports = [
    ./browsers/zen.nix
    ./hyprland
    ./quickshell
    ./vicinae
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    awww
    vesktop
    thunar
    telegram-desktop
  ];
}