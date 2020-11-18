#!/bin/bash

rofi_command="rofi -theme themes/appsmenu.rasi"
dir1=$HOME/.config/rofi
dir2=$dir1/themes
dir3=$dir2/shared
dir4=$dir3/resolutions
#### Options ###
top=" Top"
mid=" Middle"
sleek=" Sleek"
options="$mid\n$top\n$sleek"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $top)
        ln -s -f $dir1/config-top.rasi $dir1/config.rasi
        ln -s -f $dir2/appsmenu-top.rasi $dir2/appsmenu.rasi
        ln -s -f $dir3/settings-top.rasi $dir3/settings.rasi
        ln -s -f $dir4/1920x1080-top.rasi $dir4/1920x1080.rasi
        dunstify --replace 200 "rofi" "rofi switched to top menu"
        ;;    
    $mid)
        ln -s -f $dir1/config-middle.rasi $dir1/config.rasi
        ln -s -f $dir2/appsmenu-middle.rasi $dir2/appsmenu.rasi
        ln -s -f $dir3/settings-middle.rasi $dir3/settings.rasi
        ln -s -f $dir4/1920x1080-middle.rasi $dir4/1920x1080.rasi
        dunstify --replace 200 "rofi" "rofi switched to middle menu"
        ;;
    $sleek)
        ln -s -f $dir1/config-sleek.rasi $dir1/config.rasi
        ln -s -f $dir2/appsmenu-sleek.rasi $dir2/appsmenu.rasi
        ln -s -f $dir3/settings-sleek.rasi $dir3/settings.rasi
        ln -s -f $dir4/1920x1080-sleek.rasi $dir4/1920x1080.rasi
        dunstify --replace 200 "rofi" "rofi switched to sleek menu"
esac

