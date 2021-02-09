#!/bin/sh

#!/bin/bash

rofi_command="rofi -theme themes/icons-2.rasi"

#### Options ###
no=""
yes=""
options="$yes\n$no"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $yes)
        bspc quit
        ;;
    $no)
        exit
        ;;
esac
