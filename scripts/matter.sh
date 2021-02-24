#!/bin/bash
color=$(cat ~/.cache/wal/colors.Xresources | grep color6 | head -n 1 | cut -f 2 -d ':' | tr -d ' #')
background=$(cat ~/.cache/wal/colors.Xresources | grep background | head -n 1 | cut -f 2 -d ':' | tr -d ' #')
foreground=$(cat ~/.cache/wal/colors.Xresources | grep foreground | head -n 1 | cut -f 2 -d ':' | tr -d ' #')
sudo -A $HOME/.config/matter/matter.py -i arch arch folder arch arch -ic $color -bg $background -fg $foreground -hl $color -ff ~/.fonts/Roboto-Regular.ttf -fn Roboto Regula r -fs 16
