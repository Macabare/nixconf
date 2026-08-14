{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
    
  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  services.displayManager.ly.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  
  users.users.alex = {
    isNormalUser = true;
    description = "alex";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh; 
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

  time.timeZone = "Europe/Kyiv";

  system.stateVersion = "26.05"; # Did you read the comment?
}

