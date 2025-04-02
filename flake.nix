{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvf.url = "github:notashelf/nvf";

  };

  outputs = { self, nixpkgs, home-manager, hyprland, zen-browser, nvf, ... } @inputs:
    let

      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in {
      packages.system.default = 
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.system;
        modules = [ ./config/nvim/nvim.nix ];
      }).neovim;

      nixosConfigurations = {
        cafo = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            nvf.nixosModules.default
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.cafo = {
                imports  = [./home.nix ];
              };
              home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
            }
          {
            programs.hyprland = {
              enable = true;
              package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
            };
            # programs.nvf = {
            #   enable = true;
            #   settings.vim = {
            #     vimAlias = true;
            #     viAlias = true;
            #   };
            # };
          }
          ];
        };
      };
    };
}
