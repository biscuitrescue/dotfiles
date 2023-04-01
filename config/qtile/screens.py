import os
from libqtile.config import Screen
from libqtile import layout, bar, widget, hook
from qtile_extras import widget
from colours import *



theme = "ashes"

if theme == "ashes":
    theme = ashes[0]
elif theme == "latte":
    theme = latte[0]
elif theme == "everforest":
    theme = everforest[0]
elif theme == "palenight":
    theme = palenight[0]
elif theme == "frappe":
    theme = frappe[0]
elif theme == "mocha":
    theme = mocha[0]
elif theme == "macchiato":
    theme = macchiato[0]
elif theme == "dracula":
    theme = dracula[0]
elif theme == "one":
    theme = one[0]
elif theme == "nord":
    theme = nord[0]


xx = 25
xf = "mononoki nerd font bold"
default = [
    widget.TextBox(
        foreground=theme["teal"],
        text=" |",
        font=xf,
    ),
    widget.GroupBox(
        font="operator mono",
        fontsize=xx+1,
        margin_y=4,
        margin_x=5,
        padding_y=3,
        padding_x=4,
        borderwidth=8,
        inactive=theme["green"],
        active=theme["red"],
        rounded=True,
        urgent_alert_method="block",
        urgent_text=theme["blood"],
        highlight_color=theme["yellow"],
        highlight_method="block",
        this_current_screen_border=theme["red"],
        block_highlight_text_color=theme["black"],
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
    ),
    widget.TextBox(
        foreground=theme["red"],
        text="|",
        font=xf,
    ),
    widget.CPU(
        foreground=theme["red"],
        format=' {load_percent}%',
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
        format='{SwapUsed: .2f} GB',
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
        format=' %d %B, %a',
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
        format=' %I:%M %p',
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
            widget.UPowerWidget(
                font=xf,
                battery_width=27,
                battery_height=14,
                fontsize=xx,
                percentage_low=0.5,
                percentage_critical=0.3,
                fill_critical="#ff0000",
                fill_charge=theme["green"],
                fill_low=theme["yellow"],
                fill_normal=theme["teal"],
                border_colour=theme["teal"],
                border_critical_colour="#ff0000",
                border_low_colour=theme["yellow"],
                border_charge_colour=theme["green"],
                text_charging="",
                text_discharging="",
                text_displaytime="",
                margin=10,
            ),
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
        top=bar.Bar(
            default,
            38,
            # opacity=0.9,
            # margin=[10,10,6,10],
            background=theme["black"],
        ),
    ),
]
