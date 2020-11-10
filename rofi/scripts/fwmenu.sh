#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
on=" Turn ufw on"
off=" Turn ufw off"
# Variable passed to rofi
options="$on\n$off"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $on)
        sudo -A ufw enable && notify-send "ufw" "turned firewall on"
        ;;    
    $off)
        sudo -A ufw disable && notify-send "ufw" "turned firewall off"
        ;;
esac

