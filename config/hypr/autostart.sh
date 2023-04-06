#!/usr/bin/env bash

killall dunst
dunst &
killall nm-applet
nm-applet --indicator &
# wayblur &
killall battery
battery &
swayidle -w timeout 900 'wayblur' before-sleep 'wayblur' &
waybar &
