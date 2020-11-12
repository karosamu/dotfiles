#!/bin/sh
dir="/home/karsam/Mount"
if [ -z "$1" ]
then
    echo "No argument supplied"
else
    device=$(sudo blkid | grep $1 | cut -f 2 -d '"')
    if [ ! -d "$dir/$device" ]
    then
        mkdir $dir/$device
    fi
    sudo mount $1 $dir/$device
fi
