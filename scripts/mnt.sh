#!/bin/sh

if [ -z "$1" ]
then
    echo "No argument supplied"
else
    device=$(sudo blkid | grep $1 | cut -f 2 -d '"')
    if [ ! -d "/home/karsam/Mount/$device" ]
    then
        mkdir /home/karsam/Mount/$device
    fi
    sudo mount $1 /home/karsam/Mount/$device
fi
