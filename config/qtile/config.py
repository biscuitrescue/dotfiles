### Karttikeya's Config

from libqtile import layout
from libqtile.config import Match
from keys import keys
from groups import groups
from screens import screens
from screens import theme

border = dict(border_focus=theme["blue"], border_width=2)
layouts = [
    layout.MonadTall(
        margin=8, new_client_position="before_current", ratio=0.55, **border
    ),
    layout.TreeTab(
        font="JetbrainsMono Nerd Font Bold",
        fontsize=13,
        border_width=0,
        bg_color=theme["black"],
        active_bg=theme["red"],
        active_fg=theme["black"],
        inactive_bg=theme["black"],
        inactive_fg=theme["teal"],
        padding_left=8,
        padding_x=8,
        padding_y=6,
        sections=["ONE", "TWO", "THREE"],
        section_fontsize=15,
        section_fg=theme["blue"],
        section_top=15,
        section_bottom=15,
        level_shift=8,
        vspace=3,
        panel_width=240,
    ),
    # layout.MonadThreeCol(
    #     min_ratio=0.25,
    #     margin=8,
    #     **border,
    # ),
    layout.Max(),
]

# wl_input_rules = {
#     "1267:12608:MSFT0001:00 04F3:3140 Touchpad": InputConfig(natural_scroll=True, tap=True),
#     "*": InputConfig(natural_scroll=True, tap=True),
#     "type:keyboard": InputConfig(kb_options="ctrl:nocaps,compose:ralt"),
# }

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    **border,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="Blueman-manager"),
        Match(wm_class="Tor Browser"),
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="Tk"),
        Match(wm_class="Todogtk.py"),
        Match(wm_class="Signal Beta"),  # ssh-askpass
        Match(wm_class="Cider"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(wm_class="Gpower.py"),
        Match(title="pinentry"),  # GPG key password entry
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
