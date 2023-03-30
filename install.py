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

home_config = f"{get_home()}.config/"
home_theme = f"{get_home()}.themes/"
home_scripts = f"{get_home()}scripts/"

def check_path(dir):
    if os.path.exists(dir):
        return True
    return False


def get_lists():
    x = os.listdir()
    for i in x:
        if os.path.isdir(i):
            if i == "config":
                config = os.listdir(i)
            elif i == "themes":
                themes = os.listdir(i)
            elif i == "scripts":
                scripts = os.listdir(i)

    return {'config': config, 'scripts': scripts, 'themes': themes}


def symlink(what, config):
    for i in what:
        newconf = f"{config}{i}"
        if os.path.exists(newconf) and os.path.isdir(newconf):
            rmtree(newconf)
        run(
                f"ln -sf {os.getcwd()}/{i} {newconf}",
                shell=True
                )


schema = get_lists()

for i in schema:
    if i == 'scripts':
        path = home_scripts
        run(
                f"ln -sf {os.getcwd()}/scripts {home_scripts}",
                shell=True
                )
    else:
        if i == 'config':
            path = home_config
        elif i == 'themes':
            path = home_theme
        print(
                symlink(schema[i], path)
                )

print("\tAll setup.\n\tTerminating...")
