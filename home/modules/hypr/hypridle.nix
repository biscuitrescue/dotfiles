{
  pkgs,
  ...
}: {
  services.hypridle = {
    enable = false;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "wayblur";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "wayblur";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
