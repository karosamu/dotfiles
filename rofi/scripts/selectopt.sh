#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
sel=" selected"
rand=" random"
# Variable passed to rofi
options="$sel\n$rand"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $sel)
        echo $1
        bash $HOME/.config/rofi/scripts/selectwal.sh $1
        ;;    
    $rand)
        notify-send "pywal" "applying new theme"
        wall=$(ls $1/*.{jpg,png} | sort -R | sort -R | sort -R | head -n 1)
        pywal $wall
        notify-send "pywal" "finished applying new theme"
        ;;
esac

