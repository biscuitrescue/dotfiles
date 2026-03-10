import os

from keys import keys
from libqtile.config import DropDown, Group, Key, ScratchPad
from libqtile.lazy import lazy

myTerm = "kitty"
mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3 = "shift"
home = os.path.expanduser("~")


groups = [
    Group("1", label="1"),
    Group(
        "2",
        label="2",  # spawn="Brave-browser-nightly",
        # matches=[
        #     Match(wm_class=["Icecat"]),
        #     Match(wm_class=["LibreWolf"]),
        #     Match(wm_class=["Firefox"]),
        #     Match(wm_class=["firefox"]),
        #     Match(wm_class=["Vivaldi-stable"]),
        #     Match(wm_class=["Brave-browser-nightly"]),
        #     Match(wm_class=["Brave-browser"]),
        #     ]
    ),
    Group(
        "3",
        label="3",
        # matches=[
        #     Match(wm_class=["Zathura"]),
        #     Match(wm_class=["Evince"]),
        #     ],
        # layout = "treetab"
    ),
    Group(
        "4",
        label="4",
        # matches=[
        #     Match(wm_class=["discord"]),
        #     Match(wm_class=["Mailspring"]),
        #     Match(wm_class=["Session"]),
        # ]
    ),
    Group(
        "5",
        label="5",
        # matches=[
        #     Match(wm_class=["Mplayer"]),
        #     ]
    ),
    Group(
        "6",
        label="6",
        # matches=[
        #     Match(wm_class=["pcmanfm"]),
        #     Match(wm_class=["qBittorrent"]),
        #     ]
    ),
    Group(
        "7",
        label="7",
        # matches=[
        #     Match(wm_class=["pavucontrol"]),
        #     Match(wm_class=["Cider"])
        #     ]
    ),
    Group("8", label="8", layout="max"),
    Group(
        "9",
        label="9",
        layout="max",
        # matches=[
        #     Match(wm_class=["zoom"]),
        #     Match(wm_class=["Microsoft Teams - Preview"]),
        #     ]
    ),
    Group(
        "f",
        label="",
        # matches=[
        #     Match(wm_class=["Brave-browser"]),
        #     #     Match(wm_class=["Signal Beta"]),
        #     ]
    ),
]
for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            Key(
                [mod1, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

# ScratchPad

# mutscr = qtile_mutable_scratch.MutableScratch()
# groups.append(Group(''))

groups.append(
    ScratchPad(
        "Scratchpad",
        [
            DropDown(
                "sig",
                "signal-desktop --password-store='gnome-libsecret'",
                height=0.85,
                width=0.85,
                x=0.075,
                y=0.075,
                opacity=1,
                on_focus_lost_hide=True,
            ),
            DropDown(
                "term",
                f"{myTerm} -e tmux new -A -s Dropdown",
                # width=0.99,
                # height=0.8,
                # x=0.005,
                # y=0.19,
                width=0.975,
                height=0.95,
                x=0.0125,
                y=0.025,
                opacity=1,
                on_focus_lost_hide=False,
            ),
            DropDown(
                "fmger",
                "nautilus",
                width=0.75,
                height=0.85,
                x=0.125,
                y=0.075,
                opacity=1,
            ),
            DropDown(
                "hitop",
                myTerm + " -e htop",
                width=0.85,
                height=0.85,
                x=0.075,
                y=0.075,
                opacity=1,
            ),
            DropDown(
                "top",
                myTerm + " -e btop",
                width=0.85,
                height=0.95,
                x=0.075,
                y=0.025,
                opacity=1,
            ),
        ],
    )
)

# keys.extend([
#     EzKey('M-S-<minus>', mutscr.add_current_window()),
#     EzKey('M-C-<minus>', mutscr.remove_current_window()),
#     EzKey('M-<minus>', mutscr.toggle()),
#     ])

keys.extend(
    [
        Key([mod], "space", lazy.group["Scratchpad"].dropdown_toggle("sig")),
        Key([mod], "p", lazy.group["Scratchpad"].dropdown_toggle("term")),
        Key([mod1], "space", lazy.group["Scratchpad"].dropdown_toggle("top")),
        Key(
            [mod1, "shift"], "space", lazy.group["Scratchpad"].dropdown_toggle("hitop")
        ),
        Key([mod, "shift"], "space", lazy.group["Scratchpad"].dropdown_toggle("fmger")),
    ]
)
