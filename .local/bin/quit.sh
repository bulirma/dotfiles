#!/bin/sh

cmd="none"
cmd="$(printf  "shutdown\nrestart\nexit dwm" | dmenu -p "Action:")"
case "$cmd" in
	"shutdown") loginctl poweroff ;;
	"restart") loginctl reboot ;;
	"exit dwm") kill -TERM "$(pgrep -u "$USER" "\bdwm$")" ;;
esac

exit 0

#Shutdown
#Restart
#Log out
#Lock
#Hibernate
