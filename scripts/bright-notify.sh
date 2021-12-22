#!/bin/sh

brightnessctl s $1
notify-bar.sh 'Brightness' 100 $(brightnessctl | awk '$0~/%/{print $4}' | tr -d '()%') brightness
