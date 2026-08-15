{ self, inputs, ... }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mod = "${self}/system";
  system = import "${mod}";
  homeImports = import "${self}/home/profiles";

  specialArgs = {
    inherit inputs self;
  };
in
{
  nixosConfigurations.glushkov = nixosSystem {
    inherit specialArgs;

    modules = system.desktop ++ [
      ./glushkov

      "${mod}/programs/hyprland"
      "${mod}/programs/gamemode.nix"
      "${mod}/programs/games.nix"

      {
        home-manager = {
          users.alex.imports = [
            "${self}/home/default.nix"
            "${self}/home/profiles/glushkov"
          ];

          extraSpecialArgs = {
            inherit inputs self;
            inherit (inputs) zen-browser;
          };

          backupFileExtension = ".hm-backup";
        };
      }
    ];
  };
}