#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"
backscript="$(dirname $0)/$(basename $0) $1"
echo $backscript

#### Options ###
theme=" Theme"
network="直 Network"
rpi=" Raspberry"
mount=" Mount"
firewall=" Firewall"
bt=" Bluetooth"
hama=" Hamachi"
rofi=" Rofi"
# Variable passed to rofi
options="$theme\n$mount\n$network\n$rpi\n$hama\n$firewall\n$bt\n$rofi"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $theme)
        bash $HOME/.config/rofi/scripts/walmenu.sh $backscript
        ;;    
    $network)
        nmcli d wifi rescan | bash $HOME/.cache/networkmenu.sh
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

