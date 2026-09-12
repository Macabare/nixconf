{ ... }:

{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."mise/config.toml".text = ''
    [settings]
    idiomatic_version_file_enable_tools = ["node"]

    [tools]
    bun = "1"
    node = "24"
  '';
}
