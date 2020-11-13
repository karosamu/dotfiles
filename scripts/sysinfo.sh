#!/usr/bin/env bash


# Get user and hostname
user="$USER@$(hostname)"

# Get current volume percentage
# amixer outputs Front left and Front right values with %'s and some other info
# I grep the % lines and leave only one of them
# Then I cut to the seperator before % value which is '[', and then cut everything after th %
vol="$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)"

# Get current battery percentage
# acpi outputs a single line if there's only 1 battery, but just to make sure I grep the main battery
# 2nd field of acpi is the %, so I cut out the rest
bat="$(acpi | grep "Battery 0" | cut -d , -f2 | cut -d" " -f2)"

# Get memory
# free -m outputs headers, memory and swap in 3 lines
# with tail we cut off the headers, and use head to get memory line
# then we get the column values:
# 1st: total system memory
# 2nd: used (used here)
# 3rd: free memory (free=total-used-shared-cached)
# 4th: shared (used here)
# 5th: cached
# Get used memory
mem="$(free -m | tail -n 2 | head -n 1 | awk '{ print $3 }')"
# Get shared memory
mem2="$(free -m | tail -n 2 | head -n 1 | awk '{ print $5 }')"
# Calculate total memory
totmem="$((mem + mem2))"
# Append 'M' to all 3
totmem="$(echo $totmem | sed 's/$/M/')"
mem="$(echo $mem | sed 's/$/M/')"
mem2="$(echo $mem2 | sed 's/$/M/')"

# Get current date and time
# %a is current weekday
# %F is full date in YYYY-MM-DD format
# %H is hours in 12hr format
# %M is minutes
# %p is am/pm
date="$(date +"%a %F")"
time="$(date +"%H:%M %p")"

# Get connected wifi ssid
# nmcli outputs all interfaces in this format:
# interface_name: connected to %SSID% (if connected)
#    *** info about the interface ***
# I grep the 1st found line with "connected"
wifi="$(nmcli | grep ": connected" | head -n 1 | awk '{print $4 }')"

# Get monitor backlight percentage
# xbacklight outputs the value with very high precision
# to counter it I add 0.5 to the value and round it up by casting it to an int
# It gets the value correctly most of the time
# If there's a better solution, feel free to suggest
bckl="$(xbacklight | awk '{print int($1+0.5)}')"

# Get OS name
# /etc/os-release has NAME and PRETTY_NAME, I grep the 1st NAME line
# Then i cut everything before the '=' (format is 'NAME="osname"') and cut the '"'
os="$(cat /etc/os-release | grep NAME | head -n 1 | cut -f 2 -d '=' | sed 's/"//g')"

# Get kernel name
# this is just personal taste, but I prefer to just have the kernel version, so I cut everything after '-'
kernel="$(uname -r | cut -f 1 -d '-')"

# Get uptime and convert it to a nice format
# uptime output format:
# $uptimesince up $uptime, $n user, ......
# cut everything after 1st, change the format to x hours and x minutes
uptime="$(uptime | cut -f 1 -d ',' | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* users.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/')"

# Get wm name
# this outputs something like this:
# _NET_SUPPORTING_WM_CHECK: window id # 0x600000
# I then get the window id from it
id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
id=${id##* }
# Then I can get the wm name with cuts
wm="$(xprop -id "$id" -notype -len 25 -f _NET_WM_NAME 8t | grep 'WM_NAME' | cut -f 2 -d '=' | sed 's/ //g;s/"//g')"

# Get package count
# Get all packages and do a line count
pkg="$(pacman -Qq | wc -l)"

# Get shell name
# Gets current shell name in /bin/shell or /usr/bin/shell
# reverses the output to something like llehs/nib/ or llehs/nib/rsu/
# cut the 1st value to '/' so w get llehs
# I then reverse it again to get the shell
sh="$(echo $SHELL | rev | cut -f 1 -d '/' | rev)"

# Send notification
# I will try to improve this later so it would be configurable, but for now it outputs everything
dunstify --replace 301 -u critical " ${user}"$'\n'" ${date}"$'\n'" ${time}"$'\n'" ${uptime}"$'\n'" ${os}"$'\n'" ${kernel}"$'\n'" ${wm}"$'\n'" ${pkg}"$'\n'" ${sh}"$'\n'" ${vol}%  ${bat}  ${bckl}%"$'\n'" ${mem}/${mem2}/${totmem}"$'\n'"直 ${wifi}"
