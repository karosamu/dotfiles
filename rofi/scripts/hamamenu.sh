#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
status=" Status:$(hamachi | grep status | cut -f 2 -d ':')"
on=" Turn hamachi on"
off=" Turn hamachi off"
# Variable passed to rofi
options="$on\n$off"
#if [ "$(systemctl status logmein-hamachi.service | grep "Active" | cut -f 2 -d '(' | cut -f 1 -d ')')" -eq "running"]; then
#    echo "?"
#    options="$status\n$options"
#fi
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"

case $chosen in
    $on)
        sudo -A systemctl start logmein-hamachi
        dunstify --replace 202 "hamachi" "hamachi was turned on"
        ;;    
    $off)
        sudo -A systemctl stop logmein-hamachi
        dunstify --replace 202 "hamachi" "hamachi was turned off"
        ;;
esac

