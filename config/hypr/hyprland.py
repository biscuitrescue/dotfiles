#!/usr/bin/env python3

from hypr.display import Display
from hypr.keybindings import Key, Keybindings
from hypr.layouts import Layout

display = Display("MyHyprland", border_width=2)

keybindings = Keybindings()

@keybindings.add("Launch terminal")
def launch_terminal():
    display.spawn("alacritty")

keybindings.add(Key("mod", "Return"), launch_terminal)

layout = Layout()

layout.add("firefox", x=0, y=0, width=800, height=600)
layout.add("xterm", x=800, y=0, width=800, height=600)

display.add_keybindings(keybindings)
display.set_layout(layout)
display.run()
