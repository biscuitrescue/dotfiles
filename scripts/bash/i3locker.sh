#!/usr/bin/env bash

# i3lock --blur=20 --ind-pos="50:718" --radius=30 --force-clock --time-pos="180:718" --layout-color=ffffff --time-color=ffffff --date-color=ffffff --greeter-color=ffffff --verif-text='' --wrong-text='' --indicator --noinput-text='' --lock-text='' --lockfailed-text='' --date-str='%A %d %b %Y' --time-str='%H:%M'
if ! $(dunstctl is-paused) ; then
    dunstctl set-paused true
fi

# i3lock -i ~/Pictures/wallpapers/wp-alien.png --blur=20 --ind-pos="50:718" --radius=30 --force-clock --time-pos="180:718" --layout-color=ffffff --time-color=ffffff --date-color=ffffff --greeter-color=ffffff --verif-text='' --wrong-text='' --indicator --noinput-text='' --lock-text='' --lockfailed-text='' --date-str='%A %d %b %Y' --time-str='%H:%M' -n
i3lock -i ~/Pictures/wallpapers/wp-abstract1_b.png \
    --blur=20\
    --force-clock\
    --time-pos="683:200"\
    --layout-color=ffffff\
    --time-color=ffffff\
    --time-font='SF Pro:style=Bold'\
    --date-font='SF Pro'\
    --date-color=ffffff\
    --greeter-color=ffffff\
    --verif-text=''\
    --wrong-text=''\
    --time-size=70\
    --date-size=18\
    --indicator\
    --noinput-text=''\
    --lock-text=''\
    --lockfailed-text=''\
    --date-str='%A %d %b %Y'\
    --time-str='%H:%M'\
    --inside-color=ffffff1c\
    --ring-color=ffffff3e\
    --line-color=ffffff00\
    --keyhl-color=00000080\
    --ringver-color=00000000\
    --separator-color=22222260\
    --insidever-color=0000001c\
    --ringwrong-color=00000055\
    --insidewrong-color=0000001c\
    --verif-color=00000000\
    --wrong-color=ff000000\
    --radius=50\
    --ind-pos="683:550"\
    -n

if $(dunstctl is-paused) ; then
    dunstctl set-paused false
fi

