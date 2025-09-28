{ config, pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./modules/core.nix
      ./modules/users.nix
      ./modules/keyd.nix
      ./modules/packages.nix
      ./modules/services.nix
    ];
}
