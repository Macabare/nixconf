{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];
      };
    };
  };
}