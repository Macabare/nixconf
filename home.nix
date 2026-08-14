{ config, pkgs, zen-browser, ... }:
{
  imports = [
    ./home
  ];

  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    awww
    zen-browser.packages.${pkgs.system}.default
    vesktop
    thunar
    telegram-desktop

    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono

     qt6.qtdeclarative
  ];
}
