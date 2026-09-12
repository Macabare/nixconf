{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];

    package = pkgs.steam.override {
      extraEnv = {
        PRESSURE_VESSEL_FILESYSTEMS_RW = "/data";
      };
    };
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam.gamescopeSession.enable = true;
  };
}