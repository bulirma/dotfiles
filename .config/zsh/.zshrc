autoload -U colors && colors

. $HOME/.local/src/git-prompt/git-prompt.sh

setopt PROMPT_SUBST

__virtualenv() {
    [ -n "$VIRTUAL_ENV" ] && echo "$( basename "$VIRTUAL_ENV" )"
}

precmd() {
	EC="$?"
	status_part=""
	if [ "$EC" != "0" ]; then
		status_part="%F{red}| $EC|"
	fi
    virtenv=""
    if [ -n "$(__virtualenv)" ]; then
        virtenv="%f| $(__virtualenv)|"
    fi
    print -rP "%B%F{yellow} %F{green}%~%F{yellow}|$virtenv%F{blue}$(__git_ps1 "|\uE725 %s|")$status_part%f%b"
    PROMPT="%B%F{yellow}>%f%b "
	unset EC
	unset status_part
    unset virtenv
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
        echo "Usage: pressmd <md_file>" >&2
        return 1
    fi
    if [[ ! -f "$1" ]]; then
        echo "Error: File '$1' does not exist." >&2
        return 1
    fi
    output="$( basename "$1" .md ).pdf"
    echo "$1" | entr pandoc -o "$output" "$1"
}

wttr() {
    if [[ $# = 0 ]]; then
        curl 'wttr.in'
        return 0
    elif [[ $# = 1 ]]; then
        curl "wttr.in/$1"
        return 0
    fi
    if [[ $1 = '-l' ]]; then
        lang="$2"
        [[ $# = 3 ]] && city=$3
    elif [[ $2 = '-l' ]]; then
        lang="$3"
        [[ $# = 3 ]] && city=$1
    fi
    req='wttr.in'
    if [[ -n $city ]]; then
        req="$req/$city"
    fi
    if [[ -n $lang ]]; then
        req="$req?lang=$lang"
    fi
    curl "$req"
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/nvm/init-nvm.sh
