#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# alias ls='ls --color=auto'
# PS1='[\u@\h \W]\$ '

set -o vi

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx

export PATH=$PATH:$HOME/go/bin
export EDITOR=nvim
export BROWSER=firefox
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 2)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 3)\]\h\[$(tput setaf 4)\]: \[$(tput setaf 5)\]\w\[$(tput setaf 4)\]]\[$(tput setaf 1)\]\\$ \[$(tput sgr0)\]"
