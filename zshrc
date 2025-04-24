export ZSH="$HOME/.oh-my-zsh"
plugins=(ssh-agent)

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

# Terminal fix.
#export TERM="xterm-256color"

# https://github.com/trapd00r/LS_COLORS
# https://github.com/Vicfred/LS_COLORS
# manually modified, included in the repo.
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
export HISTSIZE=98765
export SAVEHIST=98765

# Wait for multicharacter sequences.
KEYTIMEOUT=19

set -o vi
# precmd() { eval "fortune" }

# Useful for cleaning disks.
# Run in the directory to inspect.
ducks() {
  du -hsx *    |   # show size of each item in cwd, human-readable, stay on same filesystem
  sort -rh     |   # sort by size (reverse, human-numeric)
  head -10         # top 10
}

# change `make` default behaviour for C++.
export CXXFLAGS="-std=c++23 -O0 -ggdb3 -Wall -Wextra -Wpedantic -fsanitize=address,undefined"
#export CPPFLAGS="-I/path/to/include"
export CXX="clang++"

# Add local installed binaries to the path.
export PATH=$HOME/.local/bin:$PATH

# https://github.com/dom96/choosenim
export PATH=$HOME/.nimble/bin:$PATH

# https://www.haskell.org/ghcup/
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
