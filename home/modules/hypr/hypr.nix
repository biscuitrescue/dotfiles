{
  pkgs,
  inputs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    systemd.variables = [ "--all" ];
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    extraConfig = ''

      #layerrule = blur, waybar

      windowrule=float,class:org.gnome.Nautilus
      windowrule=size 1119 621,class:org.gnome.Nautilus

      gesture = 3, horizontal, workspace

      animations {
          bezier=overshot,0.13,0.99,0.29,1.1
          animation=windows,1,4,default,popin 80%
          animation=border,1,10,default
          animation=fade,1,10,default
          animation=workspaces,1,6,default,slide
          animation=specialWorkspace,1,4,overshot,slidevert
          enabled=0
      }
    '';

    settings = {
      # exec = [
      # ];
      exec-once = [
        "battery"
        "waybar"
        "nm-applet"
        "cppswap"
        "swayidle -w timeout 900 'wayblur' before-sleep 'wayblur'"
      ];
      decoration = {
        rounding = "0";
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      cursor.no_hardware_cursors = 1;
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          drag_lock = true;
        };
      };

      gestures = {
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      monitor = "eDP-1, 1920x1080@59.99900, auto, 1.25";

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "0xff95aec7";
        "col.inactive_border" = "0xff45475a";
        layout = "master";
        resize_on_border = true;
      };

      master = {
        special_scale_factor = 0.935;
        new_status = "master";
        new_on_top = true;
      };

      "$mod" = "SUPER";
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, rofi -show drun"
        "$mod, R, exec, rofi -show run"
        "$mod SHIFT,Q,exec, hyprctl dispatch exit"
        "$mod, Q, killactive"

        "$mod, minus, exec, wayblur"

        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioStop,exec,playerctl stop"
        ",XF86AudioPlay,exec,playerctl play-pause"

        ",XF86AudioLowerVolume,exec,makofy volume_down"
        ",XF86AudioRaiseVolume,exec,makofy volume_up"
        ",XF86AudioMute,exec,makofy volume_mute"
        ",XF86AudioMicMute,exec,mictoggle"
        ",F4,exec,mictoggle"

        "$mod,XF86AudioRaiseVolume,exec,makofy brightness_up"
        "$mod,XF86AudioLowerVolume,exec,makofy brightness_down"
        ",XF86MonBrightnessUp,exec,makofy brightness_up"
        ",XF86MonBrightnessDown,exec,makofy brightness_down"

        "$mod SHIFT,M,exec,kill_decor"
        "$mod SHIFT,B,exec,kill_border"

        "$mod CTRL,SPACE,exec,nautilus"
        ",PRINT,exec,grimshot"
        "SHIFT,PRINT,exec,grimclip"
        "$mod,PRINT,exec,grimcrop"

        "$mod,B,exec,killall -SIGUSR1 .waybar-wrapped"

        "$mod SHIFT,K,resizeactive,0 -40"
        "$mod SHIFT,J,resizeactive,0 40"
        "$mod,L,resizeactive,40 0"
        "$mod,H,resizeactive,-40 0"

        "$mod SHIFT,LEFT,movewindow,l"
        "$mod SHIFT,RIGHT,movewindow,r"
        "$mod SHIFT,UP,movewindow,u"
        "$mod SHIFT,DOWN,movewindow,d"
        "$mod SHIFT,H,movewindow,l"
        "$mod SHIFT,L,movewindow,r"
        "$mod CTRL,K,movewindow,u"
        "$mod CTRL,J,movewindow,d"

        "$mod,LEFT,movefocus,l"
        "$mod,COMMA,movefocus,l"
        "$mod,PERIOD,movefocus,r"
        "$mod,J,movefocus,d"
        "$mod,K,movefocus,u"
        "$mod,RIGHT,movefocus,r"
        "$mod,UP,movefocus,u"
        "$mod,DOWN,movefocus,d"
        "$mod,F,togglefloating"
        "$mod SHIFT,space,movetoworkspace,special:base"
        "$mod SHIFT,P,movetoworkspace,special:term"
        "$mod,space,togglespecialworkspace,base"
        "$mod,P,togglespecialworkspace,term"
        "$mod,W,fullscreen,"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 10
      ));
    };
  };
}
