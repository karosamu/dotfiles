#!/bin/sh
user=/home/karsam
dir=$user/.config
cp -r $dir/bspwm $dir/dotfiles
cp -r $dir/sxhkd $dir/dotfiles
cp -r $dir/dunst $dir/dotfiles
cp -r $dir/wal $dir/dotfiles
cp -r $dir/rofi $dir/dotfiles
cp -r $dir/polybar $dir/dotfiles
cp -r $dir/picom $dir/dotfiles
cp -r $dir/scripts $dir/dotfiles
cp $dir/alacritty.yml $dir/dotfiles
rsync -r --copy-links --exclude '.git' $dir/startpage/termstart/ $dir/dotfiles/startpage/termstart/
#cp -r $HOME/Pictures/Wallpapers $dir/dotfiles
#cp /usr/bin/pfetch $dir/dotfiles/bin/

#cp $dir/scripts/sysinfo.sh $HOME/Documents/notifetch/notifetch
