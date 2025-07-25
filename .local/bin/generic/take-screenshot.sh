#!/bin/sh

options="screen
select"
option="$( echo "$options" | rofi -dmenu -p "Option" )"
case "$option" in
	"screen")
		scrot "$HOME/pix/screenshots/$( date +'%d-%m-%y_%H:%M:%S' ).png"
		;;
	"select")
		scrot -s "$HOME/pix/screenshots/$( date +'%d-%m-%y_%H:%M:%S' ).png"
		;;
esac
