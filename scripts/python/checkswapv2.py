#!/usr/bin/env python3

from subprocess import run
from time import sleep

maxmem = 6

commands = [
    "lsblk -f | awk '/swap/ {printf $1}'",
    "free -h | awk '/Mem/ {printf $3}'",
    "lsblk | awk '/SWAP/ {printf $1}'"
]

def read(datatype):
    data = ''

    if datatype == 'disk':
        cmd = commands[0],
        alpha = True
    elif datatype == 'swap':
        cmd = commands[2]
        alpha = True
    else:
        cmd = commands[1]
        alpha = False

    l = run(
        cmd,
        shell=True,
        capture_output=True,
        text=True
    )

    raw = l.stdout.strip()

    for char in raw:
        if alpha:
            if char.isalnum():
                data += char
        else:
            if not char.isalpha():
                data += char

    return data


while True:
    swapdisk = read('swap')
    mem = read('mem')
    disk = read('disk')

    if len(swapdisk) == 0 and float(mem) >= maxmem:
        cmd = f'sudo swapon /dev/{disk}'
        run(cmd, shell=True)
    if len(swapdisk) > 0 and float(mem) < maxmem:
        cmd = f'sudo swapoff /dev/{disk}'
        run(cmd, shell=True)

    sleep(1)
