{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./xdg.nix
  ];

  environment.systemPackages = with pkgs; [
    ghostty
    git
    wget
    curl
    quickshell
    vicinae
    xdg-utils

    sound-theme-freedesktop
  ];

  programs.zsh.enable = true;

  programs.dconf.enable = true;
}
