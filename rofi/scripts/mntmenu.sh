#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi -config /home/karsam/.config/rofi/config.rasi"

#### Options ###
# Variable passed to rofi
options=$(sudo -A blkid | cut -f 1 -d ':')
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
mounted=$(mount | grep $chosen > /dev/null && echo true || echo false)
echo $mounted
if [ $? -eq 0 ]; then
    if [ $mounted = "true" ]; then
        sudo -A umount $chosen
        notify-send "mnt" "unmounted device $chosen"
    else
        sudo -A mnt $chosen
        notify-send "mnt" "mounted device $chosen"
    fi
else
    exit 1
fi
