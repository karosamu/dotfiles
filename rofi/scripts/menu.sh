#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"

#### Options ###
theme=" Theme"
network="直 Network"
rpi=" Raspberry"
mount=" Mount"
firewall=" Firewall"
bt=" Bluetooth"
hama=" Hamachi"
# Variable passed to rofi
options="$theme\n$mount\n$network\n$rpi\n$hama\n$firewall\n$bt"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $theme)
        bash $HOME/.config/rofi/scripts/walmenu.sh
        ;;    
    $network)
        bash $HOME/.cache/networkmenu.sh
        ;;
    $rpi)
        bash $HOME/.cache/rpi.sh
        ;;
    $mount)
        sudo -A bash $HOME/.config/rofi/scripts/mntmenu.sh
        ;;
    $firewall)
        sudo -A bash $HOME/.config/rofi/scripts/fwmenu.sh
        ;;
    $bt)
        bash $HOME/.config/rofi/scripts/btmenu.sh
        ;;
    $hama)
        sudo -A bash $HOME/.config/rofi/scripts/hamamenu.sh
        ;;
esac

