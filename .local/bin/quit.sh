#!/bin/sh

cmd="none"
cmd="$(printf  "shutdown\nlock\nquit\nrestart\nreload bspwm" | rofi -dmenu -p "Action")"
case "$cmd" in
	"shutdown") loginctl poweroff ;;
	"restart") loginctl reboot ;;
	"lock" ) slock ;;
	"quit" ) bspc quit ;;
	"reload bspwm" ) bspc wm -r ;;
esac

exit 0
