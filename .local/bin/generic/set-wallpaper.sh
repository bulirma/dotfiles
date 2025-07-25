#!/bin/sh

path="$HOME/.local/share/wallpaper"

wpimg="$( find "$path" -maxdepth 1 -type f -name "*.jpg" -o -name "*.png" -o -name "*jpeg" | \
	while read -r file; do
		basename $file
	done | \
	rofi -dmenu -p "Wallpaper image" )"

wpimg="$path/$wpimg"

xwallpaper --focus $wpimg
