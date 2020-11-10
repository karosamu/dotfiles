#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
power_off=" Power off"
reboot="勒 Reboot"
lock=" Lock"
suspend="鈴 Suspend"
log_out="﫼 Log out"
# Variable passed to rofi
options="$lock\n$power_off\n$reboot\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $lock)
        betterlockscreen -l dimblur -t "karsam"
        ;;    
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
	    systemctl suspend
        ;;
    $log_out)
        bspc quit
        ;;
esac

