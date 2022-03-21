#!/bin/sh

cmd="none"
cmd="$(printf  "shutdown\nrestart" | dmenu -l 2)"
case "$cmd" in
	"shutdown") poweroff ;;
	"restart") reboot ;;
esac

exit 0

#Shutdown
#Restart
#Log out
#Lock
#Hibernate
