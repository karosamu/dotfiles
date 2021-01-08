#!/bin/sh
dir=$HOME/.config
rsync -r --copy-links --exclude '.git' -rH $dir/bspwm $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/sxhkd $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/dunst $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/wal $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/rofi $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/polybar $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/picom $dir/dotfiles
rsync -r --copy-links --exclude '.git' -rH $dir/scripts $dir/dotfiles
rsync -r --copy-links --exclude '.git' $dir/alacritty.yml $dir/dotfiles
#rsync -r --copy-links --exclude '.git' ~/Downloads/squareup $dir/dotfiles/startpage/squareup
rsync -r --copy-links --exclude '.git' ~/.mozilla/firefox/*.default-release/chrome $dir/chrome
rsync -r --copy-links --exclude '.git' $dir/startpage/termstart/ $dir/dotfiles/startpage/termstart
rsync -r --copy-links --exclude '.git' ~/.themes/phocus/gtk-3.0/ $dir/dotfiles/phocus/gtk-3.0/
rsync -r --copy-links --exclude '.git' ~/.themes/phocus/scss/ $dir/dotfiles/phocus/scss/
#cp -r $HOME/Pictures/Wallpapers $dir/dotfiles
#cp /usr/bin/pfetch $dir/dotfiles/bin/

#cp $dir/scripts/sysinfo.sh $HOME/Documents/notifetch/notifetch
