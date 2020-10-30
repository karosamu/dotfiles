#!/bin/sh

xrandr --output DP1 --primary --mode 1920x1080 --rotate normal --output eDP1 --mode 1920x1080 --rotate normal --below DP1;
bspc monitor eDP1 -d VI VII VIII IX X
bspc monitor DP1 -d I II III IV V
bspc wm -r;
notify-send "xrandr" "Switched to dual-monitor";
