{
  imports = [

    ../../programs
    # ../../programs/games
    ../../programs/wayland
    ../../programs/editors/vscodium

    ../../programs/dev/go.nix

    ../../services/wallpapers
    ../../services/quickshell

    ../../services/system/polkit-agent.nix
    ../../services/system/hyprland-session.nix
    ../../services/hyprsunset

    # wayland-specific
    # ../../services/wayland/gammastep.nix
    # ../../services/wayland/hyprpaper.nix
    # ../../services/wayland/hypridle.nix
  ];
}