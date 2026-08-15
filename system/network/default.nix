{ pkgs, ... }:

{
  networking = {

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;

      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };
  };

  services.resolved.enable = true;

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = [
    ""
    "${pkgs.networkmanager}/bin/nm-online -q"
  ];
}