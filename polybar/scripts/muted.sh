#!/bin/sh

if [ $(dunstctl is-paused) = "false" ]
then
    polybar-msg -p $(pgrep polybar) hook dunst 2
    dunstctl set-paused true
else
    polybar-msg -p $(pgrep polybar) hook dunst 1
    dunstctl set-paused false
fi
