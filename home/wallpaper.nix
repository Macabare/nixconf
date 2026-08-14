{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.awww
  ];

  xdg.configFile."wallpapers".source = ./wallpapers;
  xdg.cacheHome = "${config.home.homeDirectory}/.cache";

  home.file.".cache/awww/.keep".text = "";
  
  systemd.user.services.awww-daemon = {
    Unit = {
      Description = "awww wallpaper daemon";
    };

    Service = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon";
      Restart = "on-failure";
      RestartSec = 2;
    };
  };

  systemd.user.services.wallpaper = {
    Unit = {
      Description = "Random wallpaper";
      Requires = [ "awww-daemon.service" ];
      After = [ "awww-daemon.service" ];
    };

    Service = {
      Type = "oneshot";

      ExecStart = pkgs.writeShellScript "set-random-wallpaper" ''
        wallpaper=$(
          ${pkgs.findutils}/bin/find -L "$HOME/.config/wallpapers" \
            -type f \
            \( \
              -iname '*.jpg' \
              -o -iname '*.jpeg' \
              -o -iname '*.png' \
              -o -iname '*.webp' \
            \) |
          ${pkgs.coreutils}/bin/shuf -n 1
        )

        if [ -n "$wallpaper" ]; then
          ${pkgs.awww}/bin/awww img "$wallpaper" \
            --transition-type grow \
            --transition-duration 1
        fi
      '';
    };
  };
}