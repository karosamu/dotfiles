#!/bin/bash

dir=/usr/share/applications
ext=.desktop
bkext=.desktop.bk

files=(
    "Alacritty"
    "stoken-gui-small"
    "stoken-gui"
    "yad-settings"
    "yad-icon-browser"
    "xfce4-about"
    "vim"
    "fish"
    "thunar-settings"
    "thunar-bulk-rename"
    "thunar-volman-settings"
    "qvidcap"
    "qv4l2"
    "picom"
    "org.gnome.FileRoller"
    "ocs-url"
    "nm-applet"
    "lstopo"
    "htop"
    "electron13"
    "bvnc"
    "bssh"
    "avahi-discover"
    "blueman-adapter"
)

for i in "${files[@]}"
do
    if test -f "$dir/$i$ext"; then
        echo "Moving $i$ext to $i$bkext"
        mv $dir/$i$ext $dir/$i$bkext
    fi
done