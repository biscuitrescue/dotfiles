import os
from libqtile.config import Click, Drag, KeyChord, Key
from libqtile.lazy import lazy

mod = "mod4"
mod1 = "mod1"
mod2 = "control"
mod3 = "shift"
home = os.path.expanduser('~')
myTerm = "kitty"
term2 = "alacritty"


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

# SHORTCUTS


keys = [
    Key([mod], "z", lazy.spawn("rofi -show window")),
    Key([mod], "g", lazy.spawn("rofi -show filebrowser")),
    Key([mod], "d", lazy.spawn("rofi -show drun")),
    Key([mod], "r", lazy.spawn("rofi -show run")),
    Key([mod, "shift"], "Return", lazy.spawn("albert toggle")),

    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),
    Key([], "XF86AudioMicMute", lazy.spawn("mictoggle")),
    Key([mod], "XF86AudioMicMute", lazy.spawn("pamixer --source 2725632 -t")),
    Key([], "F4", lazy.spawn("mictoggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),

    Key(["control"], "XF86AudioPlay", lazy.spawn("playerctl -p spotify \
            play-pause")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([mod], "XF86AudioRaiseVolume", lazy.spawn("sudo light -A 5")),
    Key([mod], "XF86AudioLowerVolume", lazy.spawn("sudo light -U 5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("sudo light -A 5")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("sudo light -U 5")),
    Key([mod, "control"], "a", lazy.window.toggle_floating()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster()),
    Key([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "w", lazy.window.toggle_fullscreen()),
    Key([mod], "comma", lazy.layout.decrease_ratio()),
    Key([mod], "period", lazy.layout.increase_ratio()),

    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod, "mod1"], "Down", lazy.layout.flip_down()),
    Key([mod, "mod1"], "Up", lazy.layout.flip_up()),
    Key([mod, "mod1"], "Left", lazy.layout.flip_left()),
    Key([mod, "mod1"], "Right", lazy.layout.flip_right()),
    Key([mod, "control"], "Down", lazy.layout.grow_down()),
    Key([mod, "control"], "Up", lazy.layout.grow_up()),
    Key([mod, "shift"], "l", lazy.layout.grow_left()),
    Key([mod, "shift"], "m", lazy.layout.grow_right()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "i", lazy.layout.flip()),
    Key([mod, "shift"], "h",
        lazy.layout.move_left(),
        desc='Move up a section in treetab'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.move_right(),
        desc='Move down a section in treetab'
        ),

    Key([mod], "Tab", lazy.layout.next()),
    Key([mod, "shift"], "Tab", lazy.layout.previous()),
    Key([mod1], "Tab", lazy.layout.next()),
    Key([mod1, "shift"], "Tab", lazy.layout.previous()),

    Key([mod], "b", lazy.hide_show_bar()),
    Key([mod], "s", lazy.next_layout()),
    Key([mod], "a", lazy.prev_layout()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod], "c", lazy.reload_config()),
    Key([mod, "shift"], "x", lazy.spawn("poweroff")),

    Key(["shift"], "Print", lazy.spawn("clip")),
    Key(["control"], "Print", lazy.spawn("vmcrop")),
    Key(["control"], "Print", lazy.spawn("crop")),
    Key([mod], "Print", lazy.spawn("winclip")),
    Key([], "Print", lazy.spawn("shot")),

    # APPLICATIONS

    Key([mod, "shift"], "Return", lazy.spawn(term2)),
    Key([mod, "shift"], "a", lazy.spawn("./.lock.sh")),
    Key([mod], "KP_Subtract", lazy.spawn("./.lock.sh")),
    Key([mod], "KP_Add", lazy.spawn("i3lock -c 000000")),
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "o", lazy.spawn("emacsclient -n -c -a ''")),
    Key([mod], "KP_Enter", lazy.spawn(myTerm)),
    Key([mod], "v", lazy.spawn("pavucontrol")),
    Key([], "F9", lazy.spawn("pavucontrol")),
    Key([mod, "control"], 'd', lazy.spawn('dunstop')),
    Key([mod, "shift"], 's', lazy.spawn('flatpak run sh.cider.Cider')),

    KeyChord([mod], "i", [
        Key([], "f", lazy.spawn("firefox")),
        Key([], "v", lazy.spawn("vivaldi-stable")),
        Key([], "b", lazy.spawn("brave")),
        Key([], "q", lazy.spawn("qutebrowser")),
        Key([], "l", lazy.spawn("librewolf")),
    ]),
    # EDITORS
    KeyChord([mod], "e", [
        Key([], "e", lazy.spawn("emacs")),
        Key([], "v", lazy.spawn("vscodium")),
        Key([], "n", lazy.spawn("neovide")),
    ]),
    # XSS-LOCK
    KeyChord([mod], "t", [
        Key([], "x", lazy.spawn("killall xss-lock")),
        Key([], "r", lazy.spawn(
            "xss-lock --transfer-sleep-lock -- ./.lock.sh --nofork"
        ))
            ]),
    # DMSCRIPTS
    KeyChord([mod], "x", [
        Key([], "c", lazy.spawn("bash /home/cafo/dmscripts/dmconf")),
        Key([], "p", lazy.spawn("bash /home/cafo/dmscripts/dmpy")),
        Key([], "f", lazy.spawn("bash /home/cafo/dmscripts/dmfeh")),
        Key([], "b", lazy.spawn("bash /home/cafo/dmscripts/pylaunch")),
        Key([], "s", lazy.spawn("bash /home/cafo/dmscripts/dmswitch")),
            ]),

    # REDSHIFT
    KeyChord([mod, 'shift'], "r", [
        Key([], "1", lazy.spawn("redshift -O 6000")),
        Key([], "2", lazy.spawn("redshift -O 5000")),
        Key([], "3", lazy.spawn("redshift -O 4500")),
        Key([], "4", lazy.spawn("redshift -O 4250")),
        Key([], "5", lazy.spawn("redshift -O 4000")),
        Key([], "6", lazy.spawn("redshift -O 3500")),
        Key([], "x", lazy.spawn("redshift -x")),
            ]),
    ]


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]
