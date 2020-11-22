#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"
#### Options ###
back=" back"
sel=" selected"
rand=" random"
# Variable passed to rofi
options=$(ls -d "$1"/* | sed "s:\($1\)\(.*\)\/:\2:")
options="$rand\n$options"
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
if [ $? -eq 0 ]; then
    case $chosen in
        $rand)
            notify-send "pywal" "applying new theme"
            wall=$(ls $1/*.{jpg,png} | sort -R | sort -R | sort -R | head -n 1)
            pywal $wall
            notify-send "pywal" "finished applying new theme"
            ;;
        *)
            notify-send "pywal" "applying new theme"
            pywal $1/$chosen
            notify-send "pywal" "finished applying newe theme"
            ;;
    esac
fi
