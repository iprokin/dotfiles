#bindkey -v # vi mode

export PATH="/home/ilya/sh:/usr/local/bin:$PATH"
export PYTHONPATH="/home/ilya/Sync/MyPy"
export VISUAL=vim
export EDITOR=vim
export BROWSER=qutebrowser
export TERM=xterm-256color
. ~/sh/lesscolors.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ilya/.zshrc'

setopt autocd

autoload -Uz compinit
compinit
# End of lines added by compinstall
# autoload -U promptinit
# promptinit
# prompt adam2

source /usr/share/zsh/scripts/antigen/antigen.zsh
antigen use oh-my-zsh
antigen theme bira
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle tarruda/zsh-autosuggestions
antigen bundle git

bindkey -v

#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Add history-substring-search-* widgets to list of widgets that clear the autosuggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
#bindkey -M vicmd 'l' autosuggest-accept
bindkey '^l' autosuggest-accept

antigen bundle zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys
#zmodload zsh/terminfo
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ranger-cd
ranger-cd() {
 tempfile=$(mktemp)
 ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
 test -f "$tempfile" &&
 if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
   cd -- "$(cat "$tempfile")"
 fi
 rm -f -- "$tempfile"
}
# This binds Ctrl-O to ranger-cd:
zle -N ranger-cd
bindkey '^r' ranger-cd

# source /usr/share/zsh/plugins/zsh-autosuggestions/autosuggestions.zsh
# zle-line-init() {
#   zle autosuggest-start
# }
# zle -N zle-line-init
 
# # Accept suggestions without leaving insert mode
# bindkey '^f' vi-forward-word
# # or
# bindkey '^f' vi-forward-blank-word


# aliases and functions

alias tmux="TERM=tmux-256color tmux $@"

function svim() { st -e vim $@ & }
function chrme() { chromium --app=http://$1/notebooks/$2 & }

alias la="ls -al"
alias lsg="ls | grep"
alias lag="ls -al | grep"
alias cdp="cd ~/Sync/PhD"
alias cdnm="cd ~/Sync/PhD/newestest_modular_model1"
alias cdsp="cd /home/ilya/GitHub/suppositoire/scripts"
alias G="grep"
alias HG="history | grep"

function pidgrep() { ps axu | grep -i $1 | awk '{print $2}' }
function skillf () { pidgrep $1 | xargs kill $2 }
function sskillf () { pidgrep $1 | xargs sudo kill $2 }
function locate() { ag $@ /etc/filesdatabase.txt }
function orphans() { sudo pacman -Rns $(pacman -Qdtq) }


. $HOME/sh/sshing.sh

# some extra functions
function iepdfl() { inkscape -z $1 --export-pdf="${1%.*}.pdf" --export-latex }
