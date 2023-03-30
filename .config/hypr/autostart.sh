#!/usr/bin/env bash

killall mako
mako &
killall xfce-polkit
xfce-polkit &
killall nm-applet
nm-applet --indicator &
wayblur &
killall battery
battery &
wbg ~/Pictures/wallpapers/lake_trees.png &
swayidle -w timeout 600 'wayblur' before-sleep 'wayblur' &
