{ config, ... }:

{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;

      extraConfig = {
        SCREENSHOTS = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];

        "text/html" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];

        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];

        "text/plain" = [ "codium.desktop" ];

        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      };
    };
  };
}