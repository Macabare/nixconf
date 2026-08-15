{ ... }:

{
  imports = [
    ./terminal
  ];
  
  home = {
    username = "alex";
    homeDirectory = "/home/alex";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

}