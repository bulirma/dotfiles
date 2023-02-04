#!/bin/sh

layouts_file="$HOME/.config/kbl/layouts"
layout_file="$HOME/.config/kbl/layout"

read -r layout <"$layout_file"
next_layout="$(sed -n "/^$layout$/ { n; p }" "$layouts_file")"
[ -z "$next_layout" ] && next_layout="$(head -n1 "$layouts_file")"
setxkbmap $next_layout
echo "$next_layout" >"$layout_file"

exit 0
