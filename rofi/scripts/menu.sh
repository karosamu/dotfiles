#!/bin/bash

rofi_command="rofi -theme themes/icons.rasi"
backscript="$(dirname $0)/$(basename $0) $1"
echo $backscript

#### Options ###
theme=""
network="直"
rpi="力"
mount=""
firewall="ﱾ"
bt=""
hama=""
rofi=""
# Variable passed to rofi
options="$firewall\n$rpi\n$theme\n$bt\n$mount"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $theme)
        bash $HOME/.config/rofi/scripts/walmenu.sh $backscript
        ;;    
    $network)
        bash $HOME/.config/rofi/scripts/networkmenu.sh
        #nmcli d wifi rescan && bash $HOME/.cache/networkmenu.sh
        ;;
    $rpi)
        bash $HOME/.cache/rpi.sh
        ;;
    $mount)
        bash $HOME/.config/rofi/scripts/mntmenu.sh
        ;;
    $firewall)
        bash $HOME/.config/rofi/scripts/fwmenu.sh
        ;;
    $bt)
        bash $HOME/.config/rofi/scripts/btmenu.sh
        ;;
    $hama)
        bash $HOME/.config/rofi/scripts/hamamenu.sh
        ;;
    $rofi)
        bash $HOME/.config/rofi/scripts/rofimenu.sh
esac

