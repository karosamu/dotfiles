#!/bin/bash

wal -i $1;
bspc wm -r;
rm $HOME/.config/discocss/custom.css;
ln -s -f $HOME/.cache/wal/custom.css $HOME/.config/discocss/custom.css;
(cd $HOME/.themes/phocus && npm run build);
cd $HOME;
wal_steam;
killall dunst;
notify-send "pywal" "Theme applied";
#betterlockscreen -u $1;

