{ pkgs, ... }:
{
  imports = [
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    libreoffice
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
  ];
}
