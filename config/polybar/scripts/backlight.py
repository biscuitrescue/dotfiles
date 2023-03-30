#!/usr/bin/env python3

from subprocess import run

def get_brightness():
    p1=run("light", capture_output=True, text=True)
    light=round(float(p1.stdout.strip()))
    backlight=f"  {light}% "
    return backlight

print(get_brightness())    
