{ config, lib, ... }:
{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      palette = "catppuccin_mocha";

      format = lib.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "$bun"
        "$nodejs"
        "$golang"
        "$dotnet"
        "$git_branch"
        "$git_status"
        "$line_break"
        "$character"
      ];

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold yellow";
      };

      hostname = {
        ssh_only = true;
        format = "in [$hostname]($style)";
        style = "bold mauve";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        format = " in [$path]($style)";
        style = "bold blue";
      };

      bun = {
        format = " via bun:[$version]($style)";
        version_format = "$major.$minor";
      };

      nodejs = {
        format = " via node:[$version]($style)";
        version_format = "$major.$minor";
      };

      golang = {
        format = " via go:[$version]($style)";
        version_format = "$major.$minor";
      };

      dotnet = {
        format = " via dotnet:[$version <$tfm>]($style)";
        version_format = "$major.$minor";
      };

      git_branch = {
        symbol = "󰘬 ";
        format = " on [$symbol$branch]($style)";
        style = "bold flamingo";
      };

      git_status = {
        format = " [$all_status$ahead_behind]($style)";
        style = "bold yellow";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";

        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";

        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";

        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";

        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };
}
