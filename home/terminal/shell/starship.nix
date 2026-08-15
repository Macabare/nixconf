{ config, ... }:
{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      format = "$directory$git_branch$git_status$character";

      palette = "catppuccin_mocha";

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold blue";
      };

      git_branch = {
        symbol = "󰘬 ";
        format = "[$symbol$branch]($style) ";
        style = "bold mauve";
      };

      git_status = {
        format = "[$all_status$ahead_behind]($style) ";
        style = "bold yellow";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      palettes.catppuccin_mocha = {
        blue = "#89b4fa";
        mauve = "#cba6f7";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        red = "#f38ba8";
        text = "#cdd6f4";
      };
    };
  };
}