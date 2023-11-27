#!/usr/bin/env python3

from subprocess import run
from datetime import datetime
from time import sleep


cmd = "switch.py "
darktheme = "ashes"
lighttheme = "latte"
file = "/home/cafo/scripts/python/theme.txt"

while True:
    now = datetime.now()
    time = int(now.strftime("%H"))

    with open(file, 'r') as f:
        theme = f.read().strip

    if time >= 5 and time <= 16:
        if theme == lighttheme:
            pass
        else:
            theme = lighttheme
            with open(file, 'w') as f:
                f.write(theme)
    else:
        if theme == darktheme:
            pass
        else:
            theme = darktheme
            with open(file, 'w') as f:
                f.write(theme)


    cmd += theme

    run(
        cmd,
        shell=True
    )
    sleep(600)
