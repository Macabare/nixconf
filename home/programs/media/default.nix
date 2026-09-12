{ pkgs, ... }:

{
  imports = [
    ./mpv.nix
  ];

  home.packages = with pkgs; [
    # audio
    pwvucontrol
    pulsemixer

    # image
    loupe
    chafa

    ffmpeg
    yt-dlp
  ];

  xdg.dataFile."sounds/freedesktop".source =
    "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop";
}
