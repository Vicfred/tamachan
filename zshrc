export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="consolata"

export UPDATE_ZSH_DAYS=1
DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

# Doge.
alias such=git
alias very=git
alias wow="git status"

# LS_COLORS
# https://github.com/trapd00r/LS_COLORS
. "$HOME/.local/share/lscolors.sh"

# Color man pages.
export PAGER=less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS=-r
export GROFF_NO_SGR=1 # <---- GENTOO FIX

# History.
export HISTSIZE=1000
export SAVEHIST=1000

fortune -cas

