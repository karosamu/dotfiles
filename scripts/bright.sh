#!/bin/bash

# You can call this script like this:
# $./bright.sh up
# $./bright.sh down
currentlight=$(xbacklight)

function get_light {
    xbacklight | awk '{print int($1+0.5)}'
}


function send_notification {
    light=`get_light`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar="─"$(seq -s "─" $(($light / 5)) | sed 's/[0-9]//g')
    echo $bar
    echo $light
	if [ $light -lt 6 ]
    then
        bar='─'
    fi
    # Send the notification
    sh /home/karsam/.config/scripts/notify-send.sh "$light""     ""$bar" -t 2000 -h string:synchronous:"$bar" --replace=555


}

case $1 in
    up)
	xbacklight -inc 10
	send_notification
	;;
    down)
	xbacklight -dec 10
	send_notification
	;;
esac
