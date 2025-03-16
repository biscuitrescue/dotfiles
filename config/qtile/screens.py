import os
from libqtile.config import Screen
from libqtile import bar
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras import widget
from colours import themes
theme = "one"


theme = themes[theme]

rad = 5
decor = {
    "decorations": [
        RectDecoration(
            use_widget_background=True,
            radius=rad,
            filled=True,
            padding_y=8,
        )
    ],
    "padding": 10,
}
decor1 = {
    "decorations": [
        RectDecoration(
            use_widget_background=True,
            radius=[rad, 0, 0, rad],
            filled=True,
            padding_y=8,
        )
    ],
    "padding": 10,
}
decor2 = {
    "decorations": [
        RectDecoration(
            use_widget_background=True,
            radius=[0, rad, rad, 0],
            filled=True,
            padding_y=8,
        )
    ],
    "padding": 10,
}


xx = 14
xf = "jetbrainsmono nerd font bold"
default = [
    widget.TextBox(
        foreground=theme["teal"],
        text=" |",
        font=xf,
    ),
    widget.GroupBox(
        font="operator mono",
        fontsize=xx,
        margin_y=4,
        margin_x=5,
        padding_y=3,
        padding_x=4,
        borderwidth=8,
        inactive=theme["green"],
        active=theme["red"],
        rounded=True,
        urgent_alert_method="block",
        urgent_text=theme["red"],
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
        scale=0.4,
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
        background=theme["red"],
        foreground=theme["black"],
        format='  {load_percent}%',
        font=xf,
        fontsize=xx,
        **decor,
    ),
    widget.TextBox(
        foreground=theme["yellow"],
        text="|",
        font=xf,
    ),
    widget.Memory(
        font=xf,
        fontsize=xx,
        background=theme["yellow"],
        foreground=theme["black"],
        measure_mem='G',
        measure_swap='G',
        format=' {MemUsed: .2f} GB',
        **decor,
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
        foreground=theme["black"],
        background=theme["magenta"],
        measure_swap='G',
        format='{SwapUsed: .2f} GB',
        **decor,
    ),
    widget.TextBox(
        foreground=theme["green"],
        text="|",
        font=xf,
    ),
    widget.Volume(
        mouse_callbacks={'Button3': lambda: qtile.cmd_spawn("pavucontrol")},
        background=theme["green"],
        foreground=theme["black"],
        update_interval=0.01,
        font=xf,
        fontsize=xx,
        **decor,
    ),
    widget.TextBox(
        foreground=theme["teal"],
        text="|",
        font=xf,
    ),
    widget.Clock(
        foreground=theme["black"],
        background=theme["teal"],
        format=' %d %B, %a',
        font=xf,
        fontsize=xx,
        **decor,
    ),
    widget.TextBox(
        foreground=theme["violet"],
        text="|",
        font=xf,
    ),
    widget.Clock(
        foreground=theme["black"],
        background=theme["violet"],
        font=xf,
        fontsize=xx,
        format=' %I:%M %p',
        **decor,
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
                **decor,
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
                battery_width=24,
                battery_height=14,
                fontsize=xx,
                percentage_low=0.5,
                percentage_critical=0.3,
                fill_critical="#ff0000",
                fill_charge=theme["green"],
                fill_low=theme["yellow"],
                fill_normal=theme["black"],
                background=theme["blue"],
                border_colour=theme["black"],
                border_critical_colour=theme["black"],
                border_charge_colour=theme["black"],
                text_charging="",
                text_discharging="",
                text_displaytime="",
                margin=5,
                **decor1,
            ),
            widget.Battery(
                fontsize=xx,
                font=xf,
                low_percentage=0.25,
                low_background=theme["blue"],
                low_foreground=theme["black"],
                foreground=theme["black"],
                background=theme["blue"],
                charge_char='↑',
                discharge_char='',
                update_interval=1,
                format='{percent:2.0%}{char}',
                **decor2,
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
            37,
            # opacity=0.9,
            # margin=[8, 8, 2, 8],
            background=theme["black"],
            foreground=theme["zero"],
        ),
    ),
]
