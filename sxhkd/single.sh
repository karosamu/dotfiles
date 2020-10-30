#!/bin/sh

xrandr --auto;
bspc monitor DP1 -r
bspc monitor eDP1 -d I II III IV V VI VII VIII IX X
bspc wm -r;
notify-send "xrandr" "Switched to single-monitor";
