#!/bin/sh

muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
volume=$(amixer get Master | awk '$0~/%/{print $5}' | tr -d '[]%' | tail -n 1)
echo $muted $volume
if [ "$muted" = "no" ]; then
	    notify-bar.sh "Volume unmuted" 100 $volume volume
    else
	    notify-bar.sh "Volume muted" 100 $volume volume
fi
