
#!/bin/sh
notify-send "test";
hex=$(maim -st 0 | convert - -resize 1x1\! -format '%[pixel:p{0,0}]' info:- | awk -F '[(,)]' '{printf("%x%x%x\n",$2,$3,$4)}' | tr '[:lower:]' '[:upper:]');
a=`echo $hex | cut -c-2`
b=`echo $hex | cut -c3-4`
c=`echo $hex | cut -c5-6`
r=`echo "ibase=16; $a" | bc`
g=`echo "ibase=16; $b" | bc`
b=`echo "ibase=16; $c" | bc`

notify-send "#$hex" "($r, $g, $b)";

exit 0;
