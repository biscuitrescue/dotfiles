#!/usr/bin/env python3

from subprocess import run
import os
from shutil import rmtree


def get_home():
    a = run(
            "echo $HOME",
            shell=True,
            capture_output=True,
            text=True
            )
    return (a.stdout.strip() + "/")


def check_dir(path):
    if os.path.exists(path):
        rmtree(path)
    os.mkdir(path)


workdir = os.getcwd()
home = get_home()
home_config = f"{home}.config/"
home_theme = f"{home}.themes/"
home_scripts = f"{home}scripts/"


run(
        f"ln -sf {workdir}/config/* {home_config}",
        shell=True
        )

run(
        f"ln -sf {workdir}/themes/* {home_theme}",
        shell=True
        )

run(
        f"ln -sf {workdir}/scripts {home_scripts}",
        shell=True
        )


print("\tAll setup.\n\tTerminating...")
