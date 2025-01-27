#!/usr/bin/env bash

killall nm-applet
nm-applet &
killall battery
battery &
killall cppswap 
cppswap &
# swayidle -w timeout 900 'wayblur' before-sleep 'wayblur' &
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
# waybar -c ~/.config/waybar/backup.jsonc &
hyprpanel &
xfce-polkit &
