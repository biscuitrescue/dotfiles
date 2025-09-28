{ pkgs, ... }: {
  services = {
# logind.lidSwitch = "ignore";
    cloudflare-warp.enable = true;
    gvfs.enable = true;
    samba.enable = true;
    dbus.enable = true;

    emacs = {
      enable = true;
      package = pkgs.emacs;
    };

    # openvpn = {
    #   servers = {
    #     server = {
    #       config = ''
    #         dev tun
    #         ifconfig 10.8.0.1 10.8.0.2
    #         secret /root/static.key
    #         '';
    #       up = "ip route add ...";
    #       down = "ip route del ...";
    #     };
    #
    #     client = {
    #       config = ''
    #         client
    #         remote vpn.example.org
    #         dev tun
    #         proto tcp-client
    #         port 8080
    #         ca /root/.vpn/ca.crt
    #         cert /root/.vpn/alice.crt
    #         key /root/.vpn/alice.key
    #         '';
    #       up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
    #       down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
    #     };
    #   };
    # };


    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
          STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };
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
      displayManager = {
        startx.enable = true;
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    tailscale.enable = true;
    printing.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  }
