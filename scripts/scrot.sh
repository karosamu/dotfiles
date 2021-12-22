#!/bin/sh

file=$HOME/Pictures/Screenshots/$(date +%s).png

maim -us -c 105,117,95,0.1 -l $file -d $1 --quiet && xclip -selection clipboard -t image/png < $file

if [ -f "$file" ]; then
	notify-text.sh -i $file "Screenshot" "Copied to clipboard"
fi
