autoload -U colors && colors

#autoload -Uz vcs_info
#precmd() { vcs_info }
#zstyle ':vcs_info:*' formats '%{$fg[yellow]%}(%{$fg[blue]%}%b%{$fg[yellow]%})'

PS1="%B%{$fg[yellow]%}[%{$fg[green]%}%~%{$fg[yellow]%}]%{$fg[red]%}$%{$reset_color%}%b "

mkdir -p ~/.cache/zsh
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

alias ls='ls --color'

export EDITOR=nvim
export BROWSER=firefox

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx
