{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    curl
    wget
    fzf

    unzip
    unrar
    p7zip

    libnotify
  ];

  programs = {
    eza.enable = true;
  };
}
