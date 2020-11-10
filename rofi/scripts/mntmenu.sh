#!/bin/bash

rofi_command="rofi -theme /home/karsam/.config/rofi/themes/appsmenu.rasi"

#### Options ###
# Variable passed to rofi
options=$(sudo blkid | cut -f 1 -d ':')
chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
if [ $? -eq 0 ]; then
    mnt $chosen
else
    exit 1
fi
