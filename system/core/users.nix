{ pkgs, ... }:
{
  users.users.alex = {
    isNormalUser = true;
    description = "alex";
    extraGroups = ["networkmanager" "video" "wheel"];
    shell = pkgs.zsh; 
  };
}