#!/usr/bin/env python3

from subprocess import run
from os.path import exists
from shutil import copy

# theme = input("Enter theme name: ")

x = run(
    "echo $HOME",
    shell=True,
    capture_output=True,
    text=True
)

home = x.stdout.strip()+'/'

configs = {
    "qtile":f"{home}/.config/screens.py",
    "nvim":f"{home}/.config/nvim/init.vim",
    "kitty":f"{home}/.config/kitty/kitty.conf"
}

with open(configs["nvim"], "r") as f:
    x = f.readlines()
    for i in x:
        if "colorscheme" in i:
            line = i

line = line.split()
line = f"{line[0]} catppuccin"
print(line)

with open(configs["nvim"], "w") as f:
    f.write(line)


# for i in configs:
#     with open(configs[i], "r") as f:
#         x = f.readlines()
#         for i in x:
#             print(x)
#             quit()
