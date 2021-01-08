#!/bin/bash
walcache="~/.cache/wal"
wal -i $1;
rm $HOME/.config/discocss/custom.css;
ln -s -f $HOME/.cache/wal/custom.css $HOME/.config/discocss/custom.css;
rm $HOME/.config/fish/config.fish;
ln -s -f $HOME/.cache/wal/config.fish $HOME/.config/fish/config.fish
(cd $HOME/.themes/phocus && npm run build);
cd $HOME;
#wal_steam;
tail -n +3 "$walcache/colors.Xresources" > "$walcache/colors.Xresources.tmp" && mv $walcache/colors.Xresources.tmp $walcache/colors.Xresources
ln -s -f ~/.cache/wal/colors.Xresources ~/.config/.Xresources
killall dunst;
bspc wm -r;
notify-send "pywal" "Theme applied";
#betterlockscreen -u $1;

