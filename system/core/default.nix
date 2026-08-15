{ lib, ... }:

{
  imports = [
    ./security.nix
    ./users.nix
    ../nix
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };

  system.stateVersion = lib.mkDefault "26.05";

  time.timeZone = lib.mkDefault "Europe/Kyiv";

  zramSwap.enable = true;
}