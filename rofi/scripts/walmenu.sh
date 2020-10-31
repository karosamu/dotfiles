#declare the root directory for the pape folders
wallpaperdir="$HOME/Pictures/Wallpapers"
options=$(ls -d "$wallpaperdir"/* | sed "s:\($wallpaperdir\)\(.*\)\/:\2:")
selection=$(echo "$options" | rofi -dmenu -theme themes/appsmenu.rasi)
if [ $? -eq 0 ]; then
    if [ $selection = "random" ]
    then
	rm /tmp/wall.jpg
        wall=$(ls $HOME/Pictures/Mega/*.{jpg,png} | sort -R | head -n 1)
	cp $wall /tmp/wall.jpg
        pywal $wall
    elif [ $selection = "grub" ]    
    then
	notify-send "matter" "changing grub theme"
	matter
	notify-send "matter" "grub theme changed"
    elif [ $selection = "lock" ]
    then
	notify-send "lockscreen" "changing lockscreen wallpaper"
	betterlockscreen -u /tmp/wall.jpg
	notify-send "lockscreen" "lockscreen wallpaper changed"
    elif [ $selection = "save" ]
    then
	cp /tmp/wall.jpg "$HOME/Pictures/Wallpapers/walrandom"$(date +%s%N | cut -b10-19)".jpg"
    else
	rm /tmp/wall.jpg
        pywal $wallpaperdir/$selection
	cp $wallpaperdir/$selection /tmp/wall.jpg
    fi
else
    exit 1
fi
