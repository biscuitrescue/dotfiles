{ config, pkgs, ... }:

let
  user = "cafo";
in

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot = {
  #   kernelPackages = pkgs.linuxPackages_latest;
  #     # initrd.kernelModules = ["amdgpu"];
  #
  #     loader = {
  #       efi = {
  #         canTouchEfiVariables = true;
  #         efiSysMountPoint = "/boot";
  #       };
  #       grub = {
  #         enable = true;
  #         devices = ["nodev"];
  #         efiSupport = true;
  #         useOSProber = true;
  #         configurationLimit = 5;
  #       };
  #       timeout = 5;
  #     };
  # };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking

# Set your time zone.
  time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };


  services = {
    blueman.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;
      };
    };
    xserver = {
      enable = true;
      # displayManager = {
      #   gdm.enable = true;
      # };
      xkb = {
        layout = "us";
        variant = "";
      };
      # desktopManager = {
      #   gnome.enable = true;
      # };
      windowManager = {
        qtile = {
          enable = true;
          extraPackages = python3Packages: with python3Packages; [
            qtile-extras
          ];
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    openssh.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  users.users.${user}= {
    isNormalUser = true;
    description = "Karttikeya Sinha";
    extraGroups = [ "wheel" "audio" "input" "video" "networkmanager" "lp" "scanner" "kvm"]; 
    shell = pkgs.fish;
    packages = with pkgs; [
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
      neovim
      xclip
      starship
      tmux
      xss-lock
      libnotify
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    clang
    cmake
    llvmPackages_20.clang-tools
    gcc
    wget
    unzip
    zip
    glib
    brave
    gnumake
    killall
    pulseaudio
    lazygit
  ];

  fonts.fontDir.enable = true;

programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
};

services.dbus.enable = true;
xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
};

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "daily";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
