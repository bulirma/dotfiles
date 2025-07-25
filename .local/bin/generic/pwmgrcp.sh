#!/bin/sh

choice="$( pass ls | tail -n+2 | sed -e 's/\(├\|└\)─\+//' -e 's/[[:space:]]\+//g' -e 's/\x1b\[[0-9;]*m//g' | rofi -dmenu -p "Password" )"
[ -z "$choice" ] && exit 1
cmd='show'
code='Password'
echo "$choice" | grep -q 'otp' && cmd='otp' && code='OTP'
pass "$cmd" -c "$choice" || valid="0"
[ -z "$valid" ] && notify-send "$code for '$choice' was copied to clipboard for 45 seconds." ||
    notify-send "$code for '$choice' does not exist" && exit 1
