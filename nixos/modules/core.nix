{ lib, pkgs, ... }: {

  fileSystems = {
    "/home/cafo/vm/" = {
      device = "UUID=4a5e7d30-f2a6-4a0f-b755-99fc9814aaf0";
      mountPoint = "/home/cafo/vm";
      fsType = "ext4";
      options = [ "defaults" "rw" "user" ];
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
      };
      timeout = 5;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  time.timeZone = "Asia/Kolkata";
  time.hardwareClockInLocalTime = true;

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


  # hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;
  # virtualisation.virtualbox.host.enableHardening = false;

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  systemd.services.sshd.wantedBy = lib.mkForce [ ];
  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=no
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=no
  '';

  security = {
    polkit.enable = true;
    sudo.extraConfig = "%wheel ALL= NOPASSWD: /usr/bin/systemctl, /usr/bin/swapon, /usr/bin/swapoff, /usr/bin/rfkill, /etc/profiles/per-user/cafo/bin/light\nDefaults env_reset, pwfeedback";
    pam.services.hyprlock = { };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "daily";
  };

  nix = {
    settings = {
      max-jobs = 8;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };
}
