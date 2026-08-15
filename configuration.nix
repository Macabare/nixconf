{ config, lib, pkgs, ... }:
{

  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
    
  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  services.displayManager.ly.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  
  programs.zsh.enable = true;

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

  system.stateVersion = "26.05"; # Did you read the comment?
}
