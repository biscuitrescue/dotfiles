#!/usr/bin/env python3

from subprocess import run
from os import listdir, getcwd
from os.path import isdir
from os import remove


def check_validity(get, format_start, final):
    # For directory
    if get == ".":
        dire = getcwd()
    elif get.startswith("~"):
        dire = f"{home}/{get[2:]}"
    elif get.startswith("./"):
        dire = get[2:]
    else:
        exit("Path must be valid directory (. for current)")

    if not isdir(dire):
        exit("Path must be directory (. for current)")

    # For formats
    if format_start not in ("png", "jpg", "jpeg", "webp"):
        exit(f"{format_start} is not a supported format")
    if final not in ("png", "jpg", "jpeg", "webp"):
        exit(f"{final} is not a supported format")

    return dire


def change(dire, format_start, final):
    pics = listdir(dire)
    for i in pics:
        if not isdir(f"{dire}/{i}") and i.endswith(format_start):
            i = i[:len(i)-len(format_start)]
            run(
                    f"convert {dire}/{i}{format_start} {dire}/{i}{final}",
                    shell=True
            )
            remove(f"{dire}/{i}{format_start}")


home = run(
        "echo $HOME",
        shell=True,
        capture_output=True,
        text=True
    )

home = home.stdout.strip()

get = input("Directory: ")
format_start = input("Format to convert: ")
final = input("Format to change to: ")

dire = check_validity(get, format_start, final)
change(dire, format_start, final)
