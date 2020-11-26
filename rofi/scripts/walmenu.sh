wallpaperdir="$HOME/Pictures/Wallpapers"
options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
backscript="$HOME/.config/rofi/scripts/menu.sh"
echo $backscript
back=" back"
lock=" lock"
save=" save"
grub=" grub"
random=" random"
options="$random\n$save\n$lock\n$grub\n$options"
selection=$(echo -e "$options" | rofi -dmenu -theme themes/appsmenu.rasi)
if [ $? -eq 0 ]; then
    case $selection in
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
            sudo $HOME/.config/matter/matter.py -i arch folder arch arch arch -ic $(xrdb ~/.Xresources -query all | grep color6 | cut -f2 | head -n 1 | tr -d '#') -bg $(xrdb ~/.Xresources -query all | grep background | cut -f2 | head -n 1 | tr -d '#') -fg $(xrdb ~/.Xresources -query all | grep foreground | cut -f2 | head -n 1 |  tr -d '#') -hl $(xrdb ~/.Xresources -query all | grep color6 | cut -f2 | head -n 1 | tr -d '#') -ff ~/Downloads/Roboto-Regular.ttf -fn Roboto Regular -fs 16
            # sudo -A matter
            notify-send "grub" "grub theme changed"
            ;;
        *)
            bash $HOME/.config/rofi/scripts/selectopt.sh $wallpaperdir/$selection/
            ;;
    esac
else
    exit 1
fi
