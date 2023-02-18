#!/bin/sh

cmd="none"
cmd="$( printf  "shutdown\nlock\nrestart\nquit" | rofi -dmenu -p "Action" )"
case "$cmd" in
	"shutdown") loginctl poweroff ;;
	"restart") loginctl reboot ;;
	"lock" ) slock ;;
	"quit" ) herbstclient quit ;;
esac
