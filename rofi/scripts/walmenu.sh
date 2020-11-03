wallpaperdir="$HOME/Pictures/Wallpapers"
options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
selection=$(echo "$options" | rofi -dmenu -theme themes/appsmenu.rasi)
if [ $? -eq 0 ]; then
    if [ $selection = "random" ]
    then
	notify-send "pywal" "applying new theme"
        wall=$(ls $HOME/Pictures/Mega/*.{jpg,png} | sort -R | head -n 1)
	echo $wall
        pywal $wall
    elif [ $selection = "lock" ]
    then
	notify-send "lockscreen" "changing lockscreen wallpaper"
	betterlockscreen -u $(cat $HOME/.cache/wal/wal)
	notify-send "lockscreen" "lockscreen wallpaper changed"
    elif [ $selection = "save" ]
    then
	cp $(cat $HOME/.cache/wal/wal) $wallpaperdir"/"$(date +%s%N | cut -b10-19)".jpg"
    else
        pywal $wallpaperdir/$selection
    fi
else
    exit 1
fi
