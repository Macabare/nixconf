{ config, lib, pkgs, ... }:
{
  systemd.user.services.hyprsunset = {
    Unit = {
      Description = "Hyprsunset";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = lib.getExe pkgs.hyprsunset;
      Restart = "on-failure";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}