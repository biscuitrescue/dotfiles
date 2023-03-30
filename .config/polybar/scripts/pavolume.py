#!/usr/bin/env python3

from subprocess import run
from time import sleep

def reloadsink():
    cmd="pactl get-default-sink"
    p1=run(cmd, shell=True, capture_output=True, text=True)
    active_sink=p1.stdout.strip()
    return active_sink

def check_mute():
    reloadsink()
    cmd="pamixer --get-mute"
    p1=run(
        cmd,
        shell=True,
        capture_output=True,
        text=True,
    )
    mute=p1.stdout.strip()
    if mute=="true":
        return "Mute"
    else:
        cmd="pamixer --get-volume-human"
        p1=run(cmd, shell=True, capture_output=True, text=True)
        vol=p1.stdout.strip()
        return vol

    sleep(2)

print(check_mute())
