#!/usr/bin/env bash

killall dunst
dunst &
killall xfce-polkit
xfce-polkit &
killall nm-applet
nm-applet --indicator &
# wayblur &
killall battery
battery &
wbg ~/Pictures/wallpapers/beachhouses.png &
swayidle -w timeout 900 'wayblur' before-sleep 'wayblur' &
waybar &
