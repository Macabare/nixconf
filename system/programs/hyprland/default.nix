{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprland
    # hyprpaper
    hyprsunset
  ];

  services.displayManager.ly.enable = true;
}