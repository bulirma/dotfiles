#!/bin/sh

get_mountable() {
	mountable="$( lsblk -lp | grep 'part $' | awk '{ print "[" $1, "(" $4 ")]" }' )"
}

get_unmountable() {
	unmountable="$( lsblk -lp | grep "/run/media/$USER/.\+" | awk '{ print "[" $1, "@", $7 "]" }' )"
}

# $1 menu list
# $2 menu prompt
get_selected() {
	selected="$( echo "$1" | dmenu -p "$2" | sed -e 's/\[//g' -e 's/\]//g' -e 's/ @ / /g' | cut -d' ' -f1 )"
}

do_mount() {
	get_mountable
	[ -z "$mountable" ] && { notify-send "mountutil.sh" "Nothing to mount."; return 0; }
	get_selected "$mountable" "Mount device:"
	[ -z "$selected" ] && return 1
	msg="$( udisksctl mount -b "$selected" )"
	notify-send "mountutil.sh" "$msg"
}

do_unmount() {
	get_unmountable
	[ -z "$unmountable" ] && { notify-send "mountutil.sh" "Nothing to unmount."; return 0; }
	get_selected "$unmountable" "Unmount device:"
	[ -z "$selected" ] && return 1
	udisksctl unmount -b "$selected" >/dev/null
	notify-send "mountutil.sh" "Device unmounted."
}

do_eject() {
	get_unmountable
	[ -n "$unmountable" ] && do_unmount ||
		{ get_mountable; [ -n "$mountable" ] && get_selected "$mountable" "Eject device:" || { notify-send "mountutil.sh" "Nothing to eject."; return 0; }; }
	[ -z "$selected" ] && return 1
	udisksctl power-off -b "$selected" >/dev/null
	notify-send "mountutil.sh" "Device ejected."
}

print_help() {
	printf "mountutil.sh accepts either one of these swithes:\n -m\tfor mounting procedure\n -u\tfor unmounting procedure\n -e\tfor ejecting procedure\n"
}

case "$1" in
	-m) do_mount || exit 1 ;;
	-u) do_unmount || exit 1 ;;
	-e) do_eject  || exit 1 ;;
	*) print_help && exit 1 ;;
esac

exit 0
