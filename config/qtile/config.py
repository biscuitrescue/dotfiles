### Karttikeya's Config

from libqtile import layout
from libqtile.config import Match
from keys import keys
from groups import groups
from screens import screens
from screens import theme


border = dict(
    border_focus=theme["blue"],
    border_width=2,
)
layouts = [
    layout.Tile(
        margin=13,
        ratio=0.55,
        # border_on_single=False,
        shift_windows=True,
        **border
    ),
    layout.MonadThreeCol(
        min_ratio=0.25,
        margin=8,
        **border,
    ),
    layout.Max(),

]
dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    **border,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='Blueman-manager'),
        Match(wm_class='Tor Browser'),
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(wm_class='Tk'),
        Match(wm_class='Todogtk.py'),
        Match(wm_class='Signal Beta'),  # ssh-askpass
        Match(wm_class='Cider'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(wm_class='Gpower.py'),
        Match(title='pinentry'),  # GPG key password entry
    ])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"
