#!/bin/bash

wal -i $1;
rm $HOME/.config/discocss/custom.css;
ln -s -f $HOME/.cache/wal/custom.css $HOME/.config/discocss/custom.css;
(cd $HOME/.themes/phocus && npm run build);
cd $HOME;
wal_steam;
betterlockscreen -u $1;
notify-send "pywal" "Theme applied";
killall dunst;
exit;

