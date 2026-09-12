{ config, ... }:
{
  imports = [
    ./programs
    ./shell/starship.nix
    ./shell/zsh.nix
    ./shell/mise.nix
  ];
}