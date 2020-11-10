#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
rgb=" RGB"
hex=" HEX"
# Variable passed to rofi
options="$hex\n$rgb"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $rgb)
        farge --no-preview --notify --rgb; xsel -b
        ;;    
    $hex)
        farge --no-preview --notify; xsel -b
        ;;
esac

