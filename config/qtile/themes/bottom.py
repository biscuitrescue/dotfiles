import os
from libqtile.config import Screen
from libqtile import qtile
from libqtile import bar, widget
from colours import themes

theme = "kanagawa"

theme = themes[theme]

xx = 13
xf = "Jetbrainsmono Nerd Font Bold"
default = [
    widget.TextBox(
        foreground=theme["teal"],
        text=" |",
        font=xf,
    ),
    widget.GroupBox(
        font=xf,
        fontsize=xx,
        margin_y=4,
        margin_x=5,
        padding_y=1,
        padding_x=5,
        borderwidth=3,
        inactive=theme["blue"],
        active=theme["red"],
        rounded=True,
        urgent_alert_method="block",
        urgent_text="#f07a78",
        highlight_color=theme["black"],
        highlight_method="line",
        this_current_screen_border=theme["red"],
        block_highlight_text_color=theme["red"],
    ),
    widget.Sep(
        padding=2,
        linewidth=0,
    ),
    widget.CurrentLayoutIcon(
        scale=0.45,
        custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
    ),


    widget.Spacer(),

    widget.Systray(
        icon_size=20,
        padding=4,
        # background="#000000",
    ),
    widget.TextBox(
        foreground=theme["red"],
        text="|",
        font=xf,
    ),
    widget.CPU(
        foreground=theme["red"],
        format='  {load_percent}%',
        font=xf,
        fontsize=xx,
    ),
    widget.TextBox(
        foreground=theme["yellow"],
        text="|",
        font=xf,
    ),
    widget.Memory(
        font=xf,
        fontsize=xx,
        foreground=theme["yellow"],
        measure_mem='G',
        measure_swap='G',
        format=' {MemUsed: .2f} GB',
    ),
    widget.TextBox(
        foreground=theme["magenta"],
        text="|",
        font=xf,
    ),
    widget.Memory(
        measure_mem='G',
        font=xf,
        fontsize=xx,
        foreground=theme["magenta"],
        measure_swap='G',
        format=' {SwapUsed: .2f} GB',
    ),
    widget.TextBox(
        foreground=theme["green"],
        text="|",
        font=xf,
    ),
    widget.Volume(
        mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
        foreground=theme["green"],
        update_interval=0.01,
        font=xf,
        fontsize=xx,
    ),
    widget.TextBox(
        foreground=theme["blue"],
        text="|",
        font=xf,
    ),
    widget.Clock(
        foreground=theme["blue"],
        format='  %d %B, %a',
        font=xf,
        fontsize=xx,
    ),
    widget.TextBox(
        foreground=theme["violet"],
        text="|",
        font=xf,
    ),
    widget.Clock(
        foreground=theme["violet"],
        font=xf,
        fontsize=xx,
        format='  %I:%M %p',
    ),
    widget.TextBox(
        foreground=theme["teal"],
        text="|",
        font=xf,
    ),
]
if len(os.listdir("/sys/class/power_supply")) == 0:
    default.extend(
        [
            widget.CapsNumLockIndicator(
                fontsize=xx,
                font=xf,
                foreground=theme["black"],
                background=theme["teal"],
            ),
            widget.TextBox(
                foreground=theme["teal"],
                text="|",
                font=xf,
            ),
        ]
    )
else:
    default.extend(
        [
            # widget.UPowerWidget(
            #     font=xf,
            #     battery_width=27,
            #     battery_height=14,
            #     fontsize=xx,
            #     percentage_low=0.5,
            #     percentage_critical=0.3,
            #     fill_critical="#ff0000",
            #     fill_charge=theme["green"],
            #     fill_low=theme["yellow"],
            #     fill_normal=theme["teal"],
            #     border_colour=theme["teal"],
            #     border_critical_colour="#ff0000",
            #     border_low_colour=theme["yellow"],
            #     border_charge_colour=theme["green"],
            #     text_charging="",
            #     text_discharging="",
            #     text_displaytime="",
            #     margin=10,
            # ),
            widget.Battery(
                fontsize=xx,
                font=xf,
                low_percentage=0.3,
                low_background=theme["black"],
                low_foreground=theme["teal"],
                foreground=theme["teal"],
                charge_char='↑',
                discharge_char='',
                update_interval=1,
                format='{percent:2.0%}{char}',
            ),
            widget.TextBox(
                foreground=theme["teal"],
                text="|",
                font=xf,
            ),
        ]
    )

screens = [
    Screen(
        bottom=bar.Bar(
            default,
            26,
            # opacity=0.9,
            # margin=[0, 0, 6, 0],
            # background="#000000",
            background=theme["black"]
        ),
    ),
]
