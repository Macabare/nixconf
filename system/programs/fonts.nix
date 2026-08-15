{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  fonts.enableDefaultPackages = false;

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrains Mono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };
}