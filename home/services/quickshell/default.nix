{ config, lib, pkgs, ... }:

let
  quickshell = pkgs.quickshell;

  dependencies = with pkgs; [
    qt6Packages.qt5compat
  ];

  qmlImportPath = lib.makeSearchPath "lib/qt-6/qml" dependencies;
in
{
  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell";
      PartOf = [
        "hyprland-session.target"
        "graphical-session.target"
      ];
      After = [ "hyprland-session.target" ];
    };

    Service = {
      Environment = [
        "PATH=/run/wrappers/bin:/run/current-system/sw/bin:${lib.makeBinPath dependencies}"
        "QML2_IMPORT_PATH=${qmlImportPath}"
        "QSG_RHI_BACKEND=vulkan"
      ];

      ExecStart = "${lib.getExe quickshell} -c main";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install.WantedBy = [ "hyprland-session.target" ];
  };
}