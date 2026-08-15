{ pkgs, config, ... }:
{

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    hyprcursor.enable = true;

    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
  };
  
  gtk = {
    enable = true;

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}