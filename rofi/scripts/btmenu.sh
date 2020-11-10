#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
off=" Off"
on=" On"
status=" Status:$(bluetooth | cut -f 2 -d '=')"
options="$status\n$on\n$off"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $on)
        bluetooth on
        ;;    
    $off)
        bluetooth off
        ;;
esac

