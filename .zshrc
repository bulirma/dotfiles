autoload -U colors && colors
PS1="%B%{$fg[blue]%}[%{$fg[green]%}%n%{$fg[blue]%}@%{$fg[yellow]%}%M%{$fg[blue]%}: %{$fg[magenta]%}%~%{$fg[blue]%}]%{$fg[red]%}$%{$reset_color%}%b "

mkdir -p ~/.cache/zsh
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_oprions+=(globdost)

alias ls='ls --color'

export PATH="$PATH:$HOME/go/bin"
export EDITOR=nvim
export WM=dwm
export BROWSER=firefox

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
