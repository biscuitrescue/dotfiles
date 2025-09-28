{ pkgs, config, ... }: {

  gtk = {
    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  # catppuccin = {
  #   flavor = "mocha";
  # };
}
