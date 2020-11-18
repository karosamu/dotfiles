#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
status=" $(sudo -A ufw status)"
on=" Turn ufw on"
off=" Turn ufw off"
# Variable passed to rofi
options="$status\n$on\n$off"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $on)
        sudo -A ufw enable && dunstify --replace 201 "ufw" "turned firewall on"
        ;;    
    $off)
        sudo -A ufw disable && dunstify --replace 201 "ufw" "turned firewall off"
        ;;
esac

