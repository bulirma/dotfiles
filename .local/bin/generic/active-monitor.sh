#!/bin/sh

xrandr --listactivemonitors |
    awk '/^\s+[0-9]+/ { print $4; }' |
    rofi -dmenu -p "Monitor"
