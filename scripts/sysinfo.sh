#!/usr/bin/env bash
notification=true
debug=false

# Possible values:
# user time date uptime os kernel wm mem bat backlight vol wifi pkg sh weather music disk
config=("user" "uptime" "os" "kernel" "wm" "mem" "pkg" "sh")
# notification urgency level
level="normal"
showupdates="true"
weather_city="London"
# disk path array ("/dev/***" "/dev/***" "dev/***")
disk_path=("/dev/nvme0n1p1")

# icons/prefixes for values
user_prefix=""
vol_prefix=""
bat_prefix=""
mem_prefix=""
date_prefix=""
time_prefix=""
wifi_prefix="直"
music_prefix=""
weather_prefix="摒"
backlight_prefix=""
os_prefix=""
kernel_prefix=""
uptime_prefix=""
wm_prefix=""
pkg_prefix=""
sh_prefix=""
disk_prefix=""

# define which os is used for packages
ospkg=$(uname -srm | cut -f 1 -d '')

for val in ${config[*]}
do
    case $val in
        user)
            user="$USER@$(cat /proc/sys/kernel/hostname)"
            argconf+=$user_prefix' '$user'\n'
        ;;
        vol)
            if command -v amixer &> /dev/null
            then
                vol="$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)"
                argconf+=$vol_prefix' '$vol'%\n'
            fi
        ;;
        disk)
            for disk in ${disk_path[*]}
            do
                if [ $(df | grep $disk | wc -l) -gt 0 ]
                then
                    disk_size="$(df -h | grep $disk | awk '{print $2}')"
                    disk_used="$(df -h | grep $disk | awk '{print $3}')"
                    disk_avail="$(df -h | grep $disk | awk '{print $4}' | sed 's/$/ free/')"
                    disk_perc_used="$(df -h | grep $disk | awk '{print $5}')"
                    argconf+=$disk_prefix' '$disk_used' / '$disk_size' ('$disk_perc_used'), '$disk_avail'\n'
                else
                    argconf+=$disk_prefix' '$disk' not mounted/connected\n'
                fi
            done
        ;;
        bat)
            if [ -d /sys/class/power_supply/*BAT*/ ]
            then
                if [ -f /sys/class/power_supply/*BAT*/capacity ]
                then
                    bat="$(cat /sys/class/power_supply/*BAT*/capacity)"
                elif command -v acpi &> /dev/null
                then
                    bat="$(acpi | cut -f 2 -d ',' | sed 's/ //g' | sed 's/%//g')"
                else
                    bat="$(awk "BEGIN {print int($(cat /sys/class/power_supply/*BAT*/charge_now)/$(cat /sys/class/power_supply/*BAT*/charge_full)*100)}")"
                fi
                argconf+=$bat_prefix' '$bat'%\n'
            fi
        ;;
        mem)
            mem="$(free -m | tail -n 2 | head -n 1 | awk '{ print $3 }')"
            mem2="$(free -m | tail -n 2 | head -n 1 | awk '{ print $5 }')"
            totmem="$((mem + mem2))"
            totmem="$(echo $totmem | sed 's/$/M/')"
            mem="$(echo $mem | sed 's/$/M/')"
            mem2="$(echo $mem2 | sed 's/$/M/')"
            argconf+=$mem_prefix' '$mem/$mem2/$totmem'\n'
        ;;
        date)
            date="$(date +"%a %F")"
            argconf+=$date_prefix' '$date'\n'
        ;;
        time)
            time="$(date +"%H:%M %p")"
            argconf+=$time_prefix' '$time'\n'
        ;;
        wifi)
            if command -v iw &> /dev/null
            then
                wifi="$(iw dev wlan0 link | grep 'SSID' | cut -f 2 -d ':' | sed 's/ //g')"
                argconf+=$wifi_prefix' '$wifi'\n'
            fi
        ;;
        music)
            if command -v mpc &> /dev/null
            then
                music="$(mpc current)"
                argconf+=$music_prefix' '$music'\n'
            fi
        ;;
        weather)
            if command -v curl &> /dev/null
            then
                    weather="$(curl -s http://wttr.in/$weather_city?format=3)"
                argconf+=$weather_prefix' '$weather'\n'
            fi
        ;;
        backlight)
            if [ -d /sys/class/backlight ]
            then
                bckl="$(awk "BEGIN {print int(($(cat /sys/class/backlight/*/brightness)/$(cat /sys/class/backlight/*/max_brightness)*100)+0.5)}")"
                argconf+=$backlight_prefix' '$bckl'%\n'
            fi
        ;;
        os)
            os="$(cat /etc/os-release | grep NAME | head -n 1 | cut -f 2 -d '=' | sed 's/"//g')"
            argconf+=$os_prefix' '$os'\n'
        ;;
        kernel)
            kernel="$(uname -r | cut -f 1 -d '-')"
            argconf+=$kernel_prefix' '$kernel'\n'
        ;;
        uptime)
            uptime="$(uptime | cut -f 1 -d ',' | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* users.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/')"
            argconf+=$uptime_prefix' '$uptime'\n'
        ;;
        wm)
            if command -v xprop &> /dev/null
            then
                id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
                id=${id##* }
                wm="$(xprop -id "$id" -notype -len 25 -f _NET_WM_NAME 8t | grep 'WM_NAME' | cut -f 2 -d '=' | sed 's/ //g;s/"//g')"
                argconf+=$wm_prefix' '$wm'\n'
            fi
        ;;
        pkg)
            has() { command -v "$1" >/dev/null; }
            pkg=`
                case $ospkg in
                    Linux*)
                        has pacman-key && pacman -Qq
                        has bonsai     && bonsai list
                        has crux       && pkginfo -i
                        has dpkg       && dpkg-query -f '.\n' -W
                        has rpm        && rpm -qa
                        has xbps-query && xbps-query -l
                        has apk        && apk info
                        has guix       && guix package --list-installed
                        has opkg       && opkg list-installed
                        has kiss       && printf '%s\n' /var/db/kiss/installed/*/
                        has cpt-list   && printf '%s\n' /var/db/cpt/installed/*/
                        has brew       && printf '%s\n' "$(brew --cellar)/"*
                        has emerge     && printf '%s\n' /var/db/pkg/*/*/
                        has pkgtool    && printf '%s\n' /var/log/packages/*
                        has eopkg      && printf '%s\n' /var/lib/eopkg/package/*
                        has nix-store  && {
                            nix-store -q --requisites /run/current-system/sw
                            nix-store -q --requisites ~/.nix-profile
                        }
                    ;;
                    Minix)
                        printf '%s\n' /usr/pkg/var/db/pkg/*/
                    ;;
                esac | wc -l
            `
            argconf+=$pkg_prefix' '$pkg'\n'
        ;;
        sh)
            sh="$(basename $SHELL)"
            argconf+=$sh_prefix' '$sh'\n'
        ;;
    esac
done

if [ $notification = 'true' ]
then
    if command -v dunstify &> /dev/null
    then
        dunstify -u $level -r 200 "notifetch" "$argconf"
    else
        notify-send -u $level "notifetch" "$argconf"
    fi
fi

if [ $debug = 'true' ]
then
    echo -ne $argconf
fi

