#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
power_off=" Power off"
reboot=" Reboot"
lock=" Lock"
suspend="鈴 Suspend"
log_out=" Log out"
# Variable passed to rofi
options="$lock\n$power_off\n$reboot\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $lock)
        betterlockscreen -l blur -t "karsam"
        ;;    
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
        betterlockscreen -l blur -s -t "karsam"
        ;;
    $log_out)
        bspc quit
        ;;
esac

