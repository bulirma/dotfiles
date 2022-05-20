#!/bin/sh

cmd="none"
cmd="$(printf  "shutdown\nlock\nrestart\nsleep\nexit dwm" | dmenu -p "Action:")"
case "$cmd" in
	"shutdown") loginctl poweroff ;;
	"restart") loginctl reboot ;;
	"lock" ) slock ;;
	"sleep" ) slock loginctl suspend ;;
	"exit dwm") kill -TERM "$(pgrep -u "$USER" "\bdwm$")" ;;
esac

exit 0

#Shutdown
#Restart
#Log out
#Lock
#Hibernate
