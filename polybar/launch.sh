#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar
kill $(grep polywins)
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
for screen in $(bspc query -M --names)
do
    echo $screen;
    polybar $screen -c ~/.config/polybar/config.ini &
    #polybar b1 -c ~/.config/polybar/config.ini &
    #polybar b2 -c ~/.config/polybar/config.ini &
    #polybar b3 -c ~/.config/polybar/config.ini &
done
