#!/bin/sh

battery="$(acpi | cut -d: -f2 | cut -d' ' -f3 | cut -d, -f1)"
volume="$(amixer sget Master | awk -F"[][]" '/dB/ { print $2 }')"
kblayout="$(setxkbmap -query | awk -F":" '/layout/ { print $2 }' | sed 's/\ //g')"
backlight="$(xbacklight -get | cut -d. -f1)"
time="$(date +'%H:%M (%d-%m-%y)')"

xsetroot -name " kbl: $kblayout | vol: $volume | bl: $backlight% | batt: $battery || $time"

exit 0
