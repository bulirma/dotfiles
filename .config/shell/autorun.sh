#!/bin/sh

run() {
    pgrep -f "$1" || "$@" &
}

run dunst
run udiskie -A -t
run nm-applet
