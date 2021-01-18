#!/bin/sh

col1=$(cat ~/.cache/wal/floats | cut -f 1 -d ",")
col2=$(cat ~/.cache/wal/floats | cut -f 2 -d ",")
col3=$(cat ~/.cache/wal/floats | cut -f 3 -d ",")

float1=$(awk -v v1=$col1 'BEGIN {print ((1/255)*v1)}')
float2=$(awk -v v1=$col2 'BEGIN {print ((1/255)*v1)}')
float3=$(awk -v v1=$col3 'BEGIN {print ((1/255)*v1)}')

giph -f $1 -s -l -c $float1,$float2,$float3,0.1 -d 3 -t $2 ~/Pictures/Gifs/$(date +%s).gif
