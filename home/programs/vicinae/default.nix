{ ... }:

{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      close_on_focus_loss = true;

      launcher_window = {
        opacity = 0.5;
      };
    };
  };
}