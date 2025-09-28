{ pkgs, config, ... }: {

  gtk = {
    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Light";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Light";
    };
  };
  # catppuccin = {
  #   flavor = "latte";
  # };
}
