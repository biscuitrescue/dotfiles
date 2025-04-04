{
  config,
  pkgs,
  system,
  inputs,
  ...
}: {
  home.username = "cafo";
  home.homeDirectory = "/home/cafo";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    qbittorrent
    htop
    feh
    grim
    oreo-cursors-plus
    nautilus
    i3lock-color
    mpv
    lazygit
    colloid-gtk-theme
    swaybg
    swaylock-effects
    swayidle
    dmenu-rs
    networkmanagerapplet
    alacritty
    bat
    eza
    git
    kitty
    wl-clipboard
    rofi
    light
    alsa-utils
    pamixer
    dunst
    mako
    glew
    maim
    feh
    polkit_gnome
    xdotool
    wmctrl
    waybar
    neofetch
    xclip
    starship
    tmux
    xss-lock
    libnotify
    inputs.zen-browser.packages."${system}".default
  ];

  home.file = {
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/hypr";
      recursive = true;
    };
    ".config/dunst" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/dunst";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/kitty";
      recursive = true;
    };
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/alacritty";
      recursive = true;
    };
    ".config/rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/rofi";
      recursive = true;
    };
    ".config/fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/fish";
      recursive = true;
    };
    ".config/mako" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/mako";
      recursive = true;
    };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/waybar";
      recursive = true;
    };
    ".config/qtile" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/cafo/git/dotfiles/config/qtile";
      recursive = true;
    };
  };

  services = {
    picom = {
      enable = true;
      backend = "glx";
      settings = {
        blur = {
          method = "gaussian";
          size = 15;
          deviation = 5.0;
        };
      };
    };
  };

  programs.neovim = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  gtk = {
    enable = true;
  };
  qt = {
    enable = true;

    platformTheme.name = "qtct";

    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=GraphiteNordDark
    '';

    "Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
  };


  programs.home-manager.enable = true;
}
