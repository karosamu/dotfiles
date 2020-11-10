#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi"

#### Options ###
status=" Status:$(hamachi | grep status | cut -f 2 -d ':')"
on=" Turn hamachi on"
off=" Turn hamachi off"
# Variable passed to rofi
options="$status\n$on\n$off"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $on)
        systemctl start logmein-hamachi
        ;;    
    $off)
        systemctl stop logmein-hamachi
        ;;
esac

