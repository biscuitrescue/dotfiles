#!/usr/bin/env python3

from subprocess import run

a = run(
    "echo $HOME",
    shell=True,
    capture_output=True,
    text=True
)
print(a.stdout.strip())
