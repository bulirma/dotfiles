#!/bin/sh

cmd="none"
cmd="$(printf  "shutdown\nrestart" | dmenu)"
case "$cmd" in
	"shutdown") loginctl poweroff ;;
	"restart") loginctl reboot ;;
esac

exit 0

#Shutdown
#Restart
#Log out
#Lock
#Hibernate
