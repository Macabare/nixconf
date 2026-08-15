{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    wget
  ];

  programs = {
    eza.enable = true;
  };
}