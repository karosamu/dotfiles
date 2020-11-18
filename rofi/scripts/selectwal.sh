#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
# Variable passed to rofi
options=$(ls -d "$1"/* | sed "s:\($1\)\(.*\)\/:\2:")
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
if [ $? -eq 0 ]; then
    case $chosen in
        *)
            notify-send "pywal" "applying new theme"
            pywal $1/$chosen
            notify-send "pywal" "finished applying new theme"
        ;;
    esac
else
    exit 1
fi
