#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
status=" Status:$(hamachi | grep status | cut -f 2 -d ':')"
on=" Turn hamachi on"
off=" Turn hamachi off"
# Variable passed to rofi
options="$status\n$on\n$off"

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

