#!/usr/bin/env python3

from subprocess import run
from sys import argv
from shutil import copyfile
from os.path import exists


a = run(
    'echo $HOME',
    shell=True,
    text=True,
    capture_output=True
)

home = a.stdout.strip() + '/'


def find_nvim():
    with open(f"{home}.config/nvim/init.lua") as f:
        x = f.readlines()
    for i in x:
        if "colorscheme" in i:
            return x.index(i)


def switch_theme(obj, theme):
    with open(f'{home}{thing[obj][1]}', 'r') as f:
        x = f.readlines()
    line = thing[obj][0][0]
    ind = thing[obj][0][1]

    old = x[line][ind[0]:ind[1]]
    new = x[line].replace(old, themes[theme][obj])

    x[line] = new
    with open(f'{home}{thing[obj][1]}', 'w') as w:
        for i in x:
            w.write(i)


themes = {
    "Everforest": {
        "openbox": "Ashes-Openbox",
        "qtile": "everforest",
        "nvim": "everforest",
        "Gtk": "Everforest-Dark",
        "Gtk4": "Everforest-Dark",
        "kitty": "everforest",
        "polybar": "ashes",
        "alacritty": "everforest_dark",
        "zathura": "everforest",
        "waybar": "everforest",
        "dunst": "everforest",
        "mako": "everforest",
        "emacs": "everforest",
        "starship": "everforest",
        "rofi": "everforest"
    },
    "Kanagawa-wave": {
        "openbox": "Ashes-Openbox",
        "qtile": "kanagawa",
        "nvim": "kanagawa-wave",
        "Gtk": "Colloid-Dark",
        "Gtk4": "Colloid-Dark",
        "kitty": "kanagawa_wave",
        "polybar": "kanagawa",
        "alacritty": "kanagawa",
        "zathura": "ashes",
        "waybar": "kanagawa",
        "dunst": "kanagawa",
        "mako": "kanagawa",
        "emacs": "kanagawa",
        "starship": "kanagawa",
        "rofi": "ashes"
    },
    "Kanagawa-lotus": {
        "openbox": "latte",
        "qtile": "latte",
        "nvim": "kanagawa-lotus",
        "Gtk": "Colloid-Light",
        "Gtk4": "Colloid-Light",
        "kitty": "kanagawa_lotus",
        "polybar": "latte",
        "alacritty": "latte",
        "zathura": "latte",
        "waybar": "kanagawa_lotus",
        "dunst": "latte",
        "mako": "latte",
        "emacs": "kanagawa",
        "starship": "catppuccin_latte",
        "rofi": "latte"
    },
    "Kanagawa": {
        "openbox": "Ashes-Openbox",
        "qtile": "kanagawa",
        "nvim": "kanagawa-dragon",
        "Gtk": "Colloid-Dark",
        "Gtk4": "Colloid-Dark",
        "kitty": "kanagawa",
        "polybar": "kanagawa",
        "alacritty": "kanagawa",
        "zathura": "ashes",
        "waybar": "kanagawa",
        "dunst": "kanagawa",
        "mako": "kanagawa",
        "emacs": "kanagawa",
        "starship": "kanagawa",
        "rofi": "ashes"
    },
    "Monokai": {
        "openbox": "Ashes-Openbox",
        "qtile": "monokai",
        "nvim": "monokai_pro",
        "Gtk": "Otis-forest",
        "Gtk4": "Otis-forest",
        "kitty": "ashes",
        "polybar": "ashes",
        "alacritty": "monokai",
        "zathura": "ashes",
        "waybar": "ashes",
        "dunst": "ashes",
        "mako": "ashes",
        "emacs": "ashes",
        "starship": "ashes",
        "rofi": "ashes"
    },
    "Ashes": {
        "openbox": "Ashes-Openbox",
        "qtile": "ashes",
        "nvim": "catppuccin-macchiato",
        "Gtk": "Otis-forest",
        "Gtk4": "Otis-forest",
        "kitty": "ashes",
        "polybar": "ashes",
        "alacritty": "ashes",
        "zathura": "ashes",
        "waybar": "ashes",
        "dunst": "ashes",
        "mako": "ashes",
        "emacs": "ashes",
        "starship": "ashes",
        "rofi": "ashes"
    },
    "One": {
        "openbox": "Doom-One",
        "qtile": "one",
        "nvim": "onedark",
        "Gtk": "Otis",
        "Gtk4": "Otis",
        "kitty": "one",
        "polybar": "one",
        "alacritty": "one",
        "zathura": "dracula",
        "waybar": "one",
        "dunst": "one",
        "mako": "one",
        "emacs": "doom-one",
        "starship": "one",
        "rofi": "one"
    },
    "Latte": {
        "openbox": "Latte-Openbox",
        "qtile": "latte",
        "nvim": "catppuccin-latte",
        "Gtk": "Colloid-Light-Catppuccin",
        "Gtk4": "Colloid-Light-Catppuccin",
        "kitty": "latte",
        "polybar": "latte",
        "alacritty": "catppuccin-latte",
        "zathura": "latte",
        "dunst": "latte",
        "mako": "latte",
        "rofi": "latte",
        "emacs": "latte",
        "starship": "catppuccin_latte",
        "waybar": "latte"
    },
    "Macchiato": {
        "openbox": "Macchiato-Openbox",
        "qtile": "macchiato",
        "nvim": "catppuccin-macchiato",
        "Gtk": "Catppuccin-Macchiato",
        "Gtk4": "Catppuccin-Macchiato",
        "kitty": "macchiato",
        "polybar": "macchiato",
        "alacritty": "macchiato",
        "zathura": "macchiato",
        "dunst": "macchiato",
        "mako": "macchiato",
        "rofi": "macchiato",
        "emacs": "macchiato",
        "starship": "catppuccin_macchiato",
        "waybar": "macchiato"
    },
    "Frappe": {
        "openbox": "Frappe-Openbox",
        "qtile": "frappe",
        "nvim": "catppuccin-frappe",
        "Gtk": "Catppuccin-Frappe",
        "Gtk4": "Catppuccin-Frappe",
        "kitty": "frappe",
        "polybar": "frappe",
        "alacritty": "frappe",
        "starship": "catppuccin_frappe",
        "zathura": "frappe",
        "dunst": "frappe",
        "mako": "frappe",
        "rofi": "frappe",
        "emacs": "frappe",
        "waybar": "frappe"
    },
    "Mocha": {
        "openbox": "Mocha-Openbox",
        "qtile": "mocha",
        "nvim": "catppuccin-mocha",
        "Gtk": "Colloid-Dark-Catppuccin",
        "Gtk4": "Colloid-Dark-Catppuccin",
        "kitty": "mocha",
        "polybar": "mocha",
        "alacritty": "catppuccin-mocha",
        "zathura": "mocha",
        "dunst": "mocha",
        "mako": "mocha",
        "rofi": "mocha",
        "emacs": "mocha",
        "starship": "catppuccin_mocha",
        "waybar": "mocha"
    },
    "Docha": {
        "openbox": "Dracula-withoutBorder",
        "qtile": "docha",
        "nvim": "catppuccin-mocha",
        "Gtk": "Colloid-Dark-Catppuccin",
        "Gtk4": "Colloid-Dark-Catppuccin",
        "kitty": "docha",
        "polybar": "dracula",
        "alacritty": "dracula",
        "zathura": "dracula",
        "dunst": "dracula",
        "mako": "dracula",
        "rofi": "dracula",
        "emacs": "doom-dracula",
        "starship": "catppuccin_mocha",
        "waybar": "dracula"
    },
    "Dracula": {
        "openbox": "Dracula",
        "qtile": "dracula",
        "nvim": "dracula",
        "Gtk": "Colloid-Dark-Dracula",
        "Gtk4": "Colloid-Dark-Dracula",
        "kitty": "dracula",
        "polybar": "dracula",
        "alacritty": "dracula",
        "zathura": "dracula",
        "dunst": "dracula",
        "mako": "dracula",
        "rofi": "dracula",
        "emacs": "doom-dracula",
        "starship": "dracula",
        "waybar": "dracula"
    },
    "Palenight": {
        "openbox": "Palenight-Openbox",
        "qtile": "palenight",
        "nvim": "palenight",
        "Gtk": "Material-Palenight-BL",
        "Gtk4": "Material-Palenight-BL",
        "kitty": "palenight",
        "polybar": "palenight",
        "alacritty": "palenight",
        "zathura": "palenight",
        "dunst": "palenight",
        "mako": "palenight",
        "rofi": "palenight",
        "emacs": "doom-palenight",
        "starship": "palenight",
        "waybar": "palenight"
    },
    "Nord": {
        "openbox": "Nord-Openbox",
        "qtile": "nord",
        "nvim": "nord",
        "Gtk": "Nordic-darker-v40",
        "Gtk4": "Nordic-darker-v40",
        "kitty": "nord",
        "polybar": "nord",
        "alacritty": "one",
        "zathura": "macchiato",
        "dunst": "nord",
        "mako": "nord",
        "rofi": "palenight",
        "emacs": "doom-nord",
        "starship": "ashes",
        "waybar": "nord"
    },
}


thing = {
    'openbox': ((42, (10, -8)), '.config/openbox/rc.xml'),
    'qtile': ((6, (9, -2)), '.config/qtile/screens.py'),
    'kitty': ((-1, (15, -6)), '.config/kitty/kitty.conf'),
    'alacritty': ((-1, (40, -8)), '.config/alacritty/alacritty.toml'),
    'Gtk': ((1, (15, -1)), '.config/gtk-3.0/settings.ini'),
    'Gtk4': ((-1, (15, -1)), '.config/gtk-4.0/settings.ini'),
    'polybar': ((0, (40, -5)), '.config/polybar/config.ini'),
    'nvim': ((find_nvim(), (21, -3)), '.config/nvim/init.lua'),
    'emacs': ((34, (18, -2)), '.config/doom/config.el'),
    'zathura': ((-1, (8, -1)), '.config/zathura/zathurarc'),
    'waybar': ((0, (16, -7)), '.config/waybar/style.css'),
    'starship': ((0, (11, -2)), '.config/starship.toml'),
    'rofi': ((-1, (8, -2)), '.config/rofi/config.rasi')
}

theme = argv[-1]

theme = theme.capitalize()

if theme not in themes:
    print("Error: Theme not found")
    exit()

obj = list(thing)

for i in obj:
    switch_theme(i, theme)


if theme in ['Mocha', 'Macchiato', 'Frappe', 'Latte']:
    with open(f"{home}.config/nvim/after/plugin/catppuccin.lua") as f:
        x = f.readlines()
    old = x[1][15:-3]
    new = x[1].replace(old, theme.lower())
    x[1] = new

    with open(f"{home}.config/nvim/after/plugin/catppuccin.lua", "w") as w:
        for i in x:
            w.write(i)
    if theme == 'Mocha':
        cmd = f"kvantummanager --set Catppuccin-{theme}-Lavender"
    else:
        cmd = f"kvantummanager --set Catppuccin-{theme}-Rosewater"
    run(
        cmd,
        shell=True
    )
else:
    run(
        "kvantummanager --set Harmony",
        shell=True
    )

run(
    f'gsettings set org.gnome.desktop.interface gtk-theme \
            {themes[theme]["Gtk"]}',
    shell=True
)

if exists(f"{home}.themes/{themes[theme]['Gtk']}/gtk-4.0/gtk.css"):
    copyfile(f"{home}.themes/{themes[theme]['Gtk']}/gtk-4.0/gtk.css",
             f"{home}.config/gtk-4.0/gtk.css")

copyfile(f"{home}.config/dunst/{themes[theme]['dunst']}",
         f"{home}.config/dunst/dunstrc")

copyfile(f"{home}.config/mako/{themes[theme]['mako']}",
         f"{home}.config/mako/config")

run(
    'qtile cmd-obj -o cmd -f reload_config',
    shell=True
)
run(
    'openbox --reconfigure',
    shell=True
)
run(
    'makoctl reload',
    shell=True
)
# run(
#     f'bash {home}.config/dunst/reload',
#     shell=True
# )
