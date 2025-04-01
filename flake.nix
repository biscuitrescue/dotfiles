{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        cafo = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.cafo = {
                imports  = [./home.nix ];
              };
            }
          {
            programs.hyprland = {
              enable = true;
              package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
          }
          ];
        };
      };
    };
}
