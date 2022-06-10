[ "$WM" = dwm ] && ~/.local/bin/loopstatus.sh &
xrdb ~/.Xresources &
picom &
exec $WM
