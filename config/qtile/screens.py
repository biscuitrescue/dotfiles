import os
from libqtile.config import Screen
from libqtile import bar, widget
from colours import themes
from typing import List


theme = "bamboo"

theme = themes[theme]

xx = 12
xf = "Monaspace Neon NF Bold"
default = [
    widget.TextBox(
        foreground=theme["teal"],
        text=" |",
        font=xf,
    ),
    widget.GroupBox(
        font=xf,
        fontsize=14,
        margin_y=4,
        margin_x=5,
        padding_y=3,
        padding_x=4,
        borderwidth=8,
        inactive=theme["violet"],
        active=theme["red"],
        rounded=True,
        urgent_alert_method="block",
        urgent_text="#f07a78",
        highlight_color=theme["yellow"],
        highlight_method="block",
        other_screen_border=theme["yellow"],  # ← add this
        this_screen_border=theme["blue"],  # ← and this
        other_current_screen_border=theme["yellow"],  # ← optional but useful
        this_current_screen_border=theme["red"],
        block_highlight_text_color=theme["black"],
    ),
    widget.Sep(
        padding=2,
        linewidth=0,
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
        format=" {load_percent}%",
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
        measure_mem="G",
        measure_swap="G",
        format="{MemUsed: .2f} GB",
    ),
    widget.TextBox(
        foreground=theme["magenta"],
        text="|",
        font=xf,
    ),
    widget.Memory(
        measure_mem="G",
        font=xf,
        fontsize=xx,
        foreground=theme["magenta"],
        measure_swap="G",
        format="{SwapUsed: .2f} GB",
    ),
    widget.TextBox(
        foreground=theme["green"],
        text="|",
        font=xf,
    ),
    widget.Volume(
        mouse_callbacks={"Button3": lambda: qtile.cmd_spawn("pavucontrol")},
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
        format=" %d %B, %a",
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
        format=" %I:%M %p",
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
            widget.Battery(
                fontsize=xx,
                font=xf,
                low_percentage=0.3,
                low_background=theme["black"],
                low_foreground=theme["teal"],
                foreground=theme["teal"],
                charge_char="↑",
                discharge_char="",
                update_interval=1,
                format="{percent:2.0%}{char}",
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
            30,
            background=theme["black"],
            # margin=[5, 10, 5, 10],
        ),
    ),
]
