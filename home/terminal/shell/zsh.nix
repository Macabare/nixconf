{ config, lib, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;

    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
      ignoreDups = true;
      share = true;
      save = 10000;
      size = 10000;
    };

    antidote = {
      enable = true;

      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-history-substring-search"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/extract"
        "Aloxaf/fzf-tab"
      ];
    };

    initContent = ''
      bindkey '^I' fzf-tab-complete
    '';

    shellAliases = {
      ".." = "cd ..";
      
      grep = "grep --color";
      ip = "ip --color";
      l = "eza -l";
      la = "eza -la";

      us = "systemctl --user"; # mnemonic for user systemctl
      rs = "sudo systemctl"; # mnemonic for root systemctl
    }
    // lib.optionalAttrs config.programs.bat.enable { cat = "bat"; };
    shellGlobalAliases = {
      eza = "eza --icons --git";
    };
  };
}