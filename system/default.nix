let
  desktop = [
    ./core
    ./core/boot.nix

    ./hardware/fwupd.nix
    ./hardware/graphics.nix
    ./hardware/nvidia.nix
    ./hardware/power.nix

    ./network

    ./programs
  ];

  laptop = desktop ++ [
    # ./hardware/bluetooth.nix

    # ./services/backlight.nix
    # ./services/power.nix
  ];
in
{
  inherit desktop laptop;
}