#bindkey -v # vi mode
#
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/scripts:/usr/local/bin:$PATH"
#export PATH="$PATH:$HOME/scripts/VIMonad"
export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$GOPATH/bin"
export PYTHONPATH="$HOME/Sync/MyPy"
export VISUAL=vim
export EDITOR=vim
export BROWSER=firefox
export TERM=xterm-256color
. ~/scripts/lesscolors.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

setopt autocd

autoload -Uz compinit
compinit
# End of lines added by compinstall
# autoload -U promptinit
# promptinit
# prompt adam2

source $HOME/.antigen.zsh
antigen use oh-my-zsh
antigen theme amuse
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle tarruda/zsh-autosuggestions
antigen bundle git
antigen bundle soimort/translate-shell
#antigen bundle Vifon/deer
antigen apply
unalias gm

bindkey -v

#zle -N deer
#bindkey '^d' deer

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

alias v="vim"
alias make="colormake"
alias tmux="TERM=screen-256color-bce tmux $@"
alias hat="highlight --out-format=ansi $@"

function svim() { st -e vim $@ & }
function ipynbo() { surf -z 1.1 http://$1/notebooks/$2 & }

alias la="ls -al"
alias lsg="ls | grep"
alias lag="ls -al | grep"
alias cdp="cd ~/Sync/PhD"
alias cdnm="cd ~/Sync/PhD/newestest_modular_model1"
alias cdt="cd ~/Sync/PhD/Documents_PhD/phd_thesis_markdown"
#alias cdsp="cd $HOME/GitHub/suppositoire/scripts"
alias G="grep"
alias HG="history | grep"

function chrme() { firejail chromium --app=http://$1/notebooks/$2 & }

function pidgrep() { ps axu | grep -i $1 | awk '{print $2}' }
function skillf () { pidgrep $1 | xargs kill $2 }
function sskillf () { pidgrep $1 | xargs sudo kill $2 }
function locate() { ag $@ /etc/filesdatabase.txt }
function orphans() { sudo pacman -Rns $(pacman -Qdtq) }

functuion togglegithome() {
  GDIR="$HOME/.git_home"
  if [ -d "$GDIR" ]; then
      mv $GDIR $HOME/.git
  else
      mv $HOME/.git $GDIR
  fi
}

. $HOME/scripts/sshing.sh

# some extra functions

function ipdfl() { inkscape -z $1 --export-pdf="${1%.*}.pdf" --export-latex }
function ipdf() { inkscape -z $1 --export-pdf="${1%.*}.pdf" }

function rfsr(); { str=${"$(cat ~/Sync/PhD/Documents_PhD/phd_thesis_markdown/source/references.bib | grep $1)":9:-1}; echo $str; echo -n "@$str" | xsel -b }

[[ $(ls -di /) != "2 /" ]] && export PS1="(chroot) $PS1"
