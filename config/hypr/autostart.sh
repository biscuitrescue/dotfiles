#!/usr/bin/env bash

killall dunst
dunst &
killall nm-applet
nm-applet --indicator &
# wayblur &
killall battery
battery &
killall cppswap 
cppswap &
swayidle -w timeout 900 'wayblur' before-sleep 'wayblur' &
waybar -c ~/.config/waybar/backup.jsonc &
xfce-polkit &
