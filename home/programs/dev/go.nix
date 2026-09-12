{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    air
    delve
    golangci-lint
  ];
}
