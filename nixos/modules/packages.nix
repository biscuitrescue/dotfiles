{ pkgs, ... }: {

  nixpkgs.overlays = [
    (final: prev: {
     jdk8 = final.openjdk8-bootstrap;
     })
  ];
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    openvpn
    direnv
    nix-direnv
    tailscale
    spotify
    vim
    clang
    discord
    cmake
    obsidian
    llvmPackages_20.clang-tools
    nmap
    libgccjit
    gcc
    wget
    unzip
    zip
    glib
    veracrypt
    baobab
    bleachbit
    brave
    tcpdump
    exfat
    exfatprogs
    gnumake
    killall
    pulseaudio
    ntfs3g
    python314
    python313Packages.pip
    protonvpn-cli
  ];

  programs = {
    command-not-found.enable = true;

    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };

    hyprland = {
      enable = true;
      withUWSM = true;
    };

    fish.enable = true;
    firefox.enable = true;
    nix-ld.enable = true;
    virt-manager.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
 } 
