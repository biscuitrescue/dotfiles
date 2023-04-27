import os
from libqtile import layout
from libqtile.config import Group, Key, Match, ScratchPad, DropDown
from libqtile.command import lazy
from keys import keys

myTerm = "alacritty"
mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3 = "shift"
home = os.path.expanduser('~')
groups = [
        Group("1", label="1"),
        Group("2", label="2", spawn="vivaldi",
              matches=[
                  Match(wm_class=["Icecat"]),
                  Match(wm_class=["LibreWolf"]),
                  Match(wm_class=["Firefox"]),
                  Match(wm_class=["firefox"]),
                  Match(wm_class=["Vivaldi-stable"]),
                  Match(wm_class=["Brave-browser-nightly"]),
                  ]
              ),


        Group("3", label="3",
              matches=[
                  Match(wm_class=["Zathura"]),
                  Match(wm_class=["Evince"]),
                  ]
              ),

        Group("4", label="4",
              matches=[
                  Match(wm_class=["discord"]),
                  Match(wm_class=["Mailspring"]),
                  Match(wm_class=["Session"]),
                  ]
              ),

        Group("5", label="5",
              matches=[
                  Match(wm_class=["Mplayer"]),
                  ]
              ),

        Group("6", label="6",
              matches=[
                  # Match(wm_class=["pcmanfm"]),
                  Match(wm_class=["qBittorrent"]),
                  ]
              ),

        Group("7", label="7",
              matches=[
                  Match(wm_class=["pavucontrol"]),
                  Match(wm_class=["Cider"])
                  ]
              ),

        Group("8", label="8", layout="max"),

        Group("9", label="9", layout="max",
              matches=[
                  Match(wm_class=["zoom"]),
                  Match(wm_class=["Microsoft Teams - Preview"]),
                  ]
              ),

        Group("0", label="10",
              matches=[
                  Match(wm_class=["Virt-manager"]),
                  Match(wm_class=["VirtualBox Manager"]),
                  ]
              ),

        Group('f', label='',
              matches=[
                  Match(wm_class=["Brave-browser"]),
                  #     Match(wm_class=["Signal Beta"]),
                  ]
              ),
]
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=False),
            desc=f"Switch to & move focused window to group {i.name}"),
        Key([mod1, "shift"], i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc=f"Switch to & move focused window to group {i.name}"),
        ])

# ScratchPad

groups.append(ScratchPad('Scratchpad', [
    DropDown("sig", "signal-desktop-beta", height=0.8,
             width=0.75, x=0.125, y=0.1, opacity=1,
             on_focus_lost_hide=True),
    DropDown("term", f'{myTerm} -e tmux new-session -t shell',
             # width=0.9, height=0.7,
             # x=0.05, y=0.01, opacity=1,
             width=0.95, height=0.9,
             x=0.025, y=0.05, opacity=1,
             on_focus_lost_hide=False),
    DropDown("vim", "neovide",
             width=0.9, height=0.9,
             x=0.05, y=0.05, opacity=1),
    DropDown("editor", "emacs",
             width=0.95, height=0.9,
             x=0.025, y=0.05, opacity=1,
             on_focus_lost_hide=False),
    DropDown("fmger", "dolphin",
             width=0.75, height=0.85,
             x=0.125, y=0.075, opacity=1),
    DropDown("Music", "spotify",
             height=0.8, opacity=1,
             width=0.9, x=0.05, y=0.05,
             on_focus_lost_hide=True),
    DropDown("fm", myTerm+' -e ranger',
             width=0.85, height=0.85,
             x=0.075, y=0.075, opacity=1),
    DropDown("hitop", myTerm+' -e htop',
             width=0.85, height=0.85,
             x=0.075, y=0.075, opacity=1),
    DropDown("dc", myTerm+' -e gord',
             width=0.7, height=0.85,
             x=0.15, y=0.075, opacity=1),
    DropDown("top", myTerm+' -e btop',
             width=0.85, height=0.95,
             x=0.075, y=0.025, opacity=1),
    ]))

keys.extend([
    Key([mod], "space",
        lazy.group['Scratchpad'].dropdown_toggle('sig')),
    Key([mod, 'shift'], "v",
        lazy.group['Scratchpad'].dropdown_toggle('vim')),
    Key([mod], "p",
        lazy.group['Scratchpad'].dropdown_toggle('term')),
    Key([mod], "o",
        lazy.group['Scratchpad'].dropdown_toggle('editor')),
    Key([mod, "shift"], "s",
        lazy.group['Scratchpad'].dropdown_toggle("Music")),
    Key([mod, "shift"], "d",
        lazy.group['Scratchpad'].dropdown_toggle("dc")),
    Key(['control'], 'space',
        lazy.group['Scratchpad'].dropdown_toggle('fm')),
    Key([mod1], 'space',
        lazy.group['Scratchpad'].dropdown_toggle('top')),
    Key([mod1, 'shift'], 'space',
        lazy.group['Scratchpad'].dropdown_toggle('hitop')),
    Key([mod, 'shift'], 'space',
        lazy.group['Scratchpad'].dropdown_toggle('fmger')),
    ])
