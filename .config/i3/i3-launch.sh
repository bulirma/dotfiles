#!/bin/sh

# autostart
~/.config/shell/autorun.sh
xwallpaper --focus ~/.local/share/wallpaper/desert_way.png
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do
	sleep 1;
done
polybar --config=~/.config/polybar/i3-polybar.ini top &
