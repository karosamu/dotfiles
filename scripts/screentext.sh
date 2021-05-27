#!/bin/sh

res=$(printf "Screen\nSelection" | rofi -dmenu -i -p 'Image to text')
dir=${XDG_CACHE_HOME:=$HOME/.cache}

case $res in
    Screen)
        maim "$dir/imgtext.png"
        tesseract "$dir/imgtext.png" "$dir/imgtext"
        xclip -sel clip < "$dir/imgtext.txt"
        rm "$dir/imgtext.txt" "$dir/imgtext.png";;
    Selection)
        maim -s "$dir/imgtext.png"
        tesseract "$dir/imgtext.png" "$dir/imgtext"
        xclip -sel clip < "$dir/imgtext.txt"
        rm "$dir/imgtext.txt" "$dir/imgtext.png";;
esac
