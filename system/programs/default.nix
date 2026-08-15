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
    btop
    quickshell
    vicinae
    xdg-utils
  ];

  programs.zsh.enable = true;

  programs.dconf.enable = true;
}