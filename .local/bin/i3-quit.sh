#!/bin/sh

cmd="none"
cmd="$( printf  "⏻ shutdown\n🔒 lock\n⭮ restart\n🚪 quit" | rofi -dmenu -p "Action" )"
case "$cmd" in
	"⏻ shutdown") poweroff ;;
	"⭮ restart") reboot ;;
	"🔒 lock" ) 
		lockimg="$HOME/.local/share/wallpaper/desert_way_grayscale.png"
        [ -n "$lockimg" ] && i3lock -i "$lockimg" || i3lock
		;;
	"🚪 quit" ) i3-msg exit ;;
esac
