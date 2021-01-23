#!/bin/sh
wallpaperdir="$HOME/Pictures/Wallpapers"
#options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
back=""
lock=""
save=""
grub=""
random=""
unsplash=" unsplash"
folders=""
options="$lock\n$grub\n$random\n$save\n$folders"
selection=$(echo -e "$options" | rofi -dmenu -theme themes/icons.rasi -selected-row 2)
if [ $? -eq 0 ]; then
    case $selection in
        $unsplash)
            bash $HOME/.config/scripts/randomunsplash.sh
            ;;
        $back)
            bash $backscript
            ;;
        $random)
            notify-send "pywal" "applying new theme"
            wall=$(ls $HOME/Pictures/Wallpapers/*/*.{jpeg,jpg,png} | sort -R | sort -R | sort -R | head -n 1)
            pywal $wall
            notify-send "pywal" "finished applying new theme"
            ;;
        $lock)
            notify-send "lockscreen" "changing lockscreen wallpaper"
            betterlockscreen -u $(cat $HOME/.cache/wal/wal)
            notify-send "lockscreen" "lockscreen wallpaper changed"
            ;;
        $save)
            nofity-send "wallpaper" "wallpaper saving"
            cp $(cat $HOME/.cache/wal/wal) $wallpaperdir"/Saved/"$(date +%s%N | cut -b10-19)".jpg"
            notify-send "wallpaper" "wallpaper saved"
            ;;
        $grub)
            notify-send "grub" "changing grub theme"
            # sudo -A matter
            sh ~/.config/scripts/matter.sh
            notify-send "grub" "grub theme changed"
            ;;
        $folders)
            sh ~/.config/rofi/scripts/foldersel.sh
            ;;
        *)
            bash $HOME/.config/rofi/scripts/selectopt.sh $wallpaperdir/$selection/
            ;;
    esac
else
    exit 1
fi
