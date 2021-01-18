#!/bin/sh

col1=$(cat ~/.cache/wal/floats | cut -f 1 -d ",")
col2=$(cat ~/.cache/wal/floats | cut -f 2 -d ",")
col3=$(cat ~/.cache/wal/floats | cut -f 3 -d ",")

float1=$(awk -v v1=$col1 'BEGIN {print ((1/255)*v1)}')
float2=$(awk -v v1=$col2 'BEGIN {print ((1/255)*v1)}')
float3=$(awk -v v1=$col3 'BEGIN {print ((1/255)*v1)}')

maim -us -c $float1,$float2,$float3,0.1 -l /tmp/screenshot.png; cat /tmp/screenshot.png | xclip -selection clipboard -t image/png; cp /tmp/screenshot.png $HOME/Pictures/Screenshots/$(date +%s).png && dunstify --replace 554 "maim" "Screenshot copied to clipboard"
