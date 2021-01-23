#!/bin/sh
wallpaperdir="$HOME/Pictures/Wallpapers"
options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
selection=$(echo -e "$options" | rofi -dmenu -theme themes/list.rasi)
if [ $? -eq 0 ]; then
    case $selection in
        *)
            bash $HOME/.config/rofi/scripts/selectopt.sh $wallpaperdir/$selection/
        ;;
    esac
else
    exit 1
fi
