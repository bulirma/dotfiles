autoload -U colors && colors

. $HOME/.local/src/git-prompt/git-prompt.sh

setopt PROMPT_SUBST

__virtualenv() {
    [ -n "$VIRTUAL_ENV" ] && echo "($( basename "$VIRTUAL_ENV" ))"
}

precmd() {
	EC="$?"
	status_part=""
	if [ "$EC" != "0" ]; then
		status_part="%{$fg[red]%}($EC)"
	fi
    print -rP "%B%{$fg[yellow]%}[%{$fg[green]%}%~%{$fg[yellow]%}]$status_part%{$reset_color%}%b"
    PROMPT="%B%{$fg[red]%}$(__virtualenv)%{$fg[blue]%}$(__git_ps1 "(%s)")%{$fg[yellow]%}>%{$reset_color%}%b "
	unset EC
	unset status_part
}

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
alias vim='nvim'
alias ghc='ghc-9.4.8'
alias ghci='ghci-9.4.8'

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

lfcd() {
	cd "$( command lf -print-last-dir "$@" )"
}

pressmd() {
    if [[ -z "$1" ]]; then
        echo "Usage: pressmd <md_file>"
        return 1
    fi
    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' does not exist."
        return 1
    fi
    output="$( basename "$1" .md ).pdf"
    echo "$1" | entr pandoc -o "$output" "$1"
}

#cds() {
#    if [ "$1" = '-c' ]; then
#        $EDITOR ~/.local/bin/generic/cds.sh
#    else
#        cd "$( ~/.local/bin/generic/cds.sh )"
#    fi
#}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
