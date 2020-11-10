wallpaperdir="$HOME/Pictures/Wallpapers"
options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
random=" random"
lock=" lock"
save=" save"
grub=" grub"
options="$random\n$lock\n$save\n$grub\n$options"
selection=$(echo -e "$options" | rofi -dmenu -theme themes/appsmenu.rasi)
if [ $? -eq 0 ]; then
    case $selection in
        $random)
            notify-send "pywal" "applying new theme"
            wall=$(ls $HOME/Pictures/Mega/*.{jpg,png} | sort -R | head -n 1)
            echo $wall
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
            cp $(cat $HOME/.cache/wal/wal) $wallpaperdir"/"$(date +%s%N | cut -b10-19)".jpg"
            notify-send "wallpaper" "wallpaper saved"
            ;;
        $grub)
            notify-send "grub" "changing grub theme"
            sudo -A matter
            notify-send "grub" "grub theme changed"
            ;;
        *)
            notify-send "pywal" "applying new theme"
            pywal $wallpaperdir/$selection
            notify-send "pywal" "finished applying new theme"
            ;;
    esac
else
    exit 1
fi
