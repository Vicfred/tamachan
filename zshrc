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
  local n=${1:-10}
  setopt GLOB_DOTS
  du -hsx -- *    \
    | sort -rh     \
    | head -n "$n"
  unsetopt GLOB_DOTS
}

# change `make` default behaviour for C++.
export CXX="clang++"
# — C++ compiler flags —
#   standard, optimizations, debug info, warnings, sanitizers, analysis
# -std=c++23                    Use the C++23 standard
# -O0                           Disable optimizations (for easier stepping)
# -ggdb3                        Emit full GDB debug info (including macro defs)
# -Wall -Wextra                 Enable most warning checks
# -Wpedantic                    Enforce strict ISO C++ compliance
# -Wconversion                  Warn on implicit conversions that may alter values
# -Wsign-conversion             Warn on signed/unsigned conversions that may change sign
# -fno-omit-frame-pointer       Keep frame pointers for accurate backtraces
# -fno-inline                   Disable function inlining to preserve call stacks
# -fsanitize=address,undefined  Catch memory- and undefined-behavior bugs
# -fsanitize=leak               Detect memory leaks on program exit
export CXXFLAGS="\
-std=c++23 \
-O0 \
-ggdb3 \
-Wall \
-Wextra \
-Wpedantic \
-Wconversion \
-Wsign-conversion \
-fno-omit-frame-pointer \
-fno-inline \
-fsanitize=address,undefined \
-fsanitize=leak"
#export CPPFLAGS="-I/path/to/include"

# Add local installed binaries to the path.
export PATH=$HOME/.local/bin:$PATH

# https://github.com/dom96/choosenim
export PATH=$HOME/.nimble/bin:$PATH

# https://www.haskell.org/ghcup/
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# list of quotes
local QUOTE_FILES=(~/.misato/quotes ~/.misato/nihongo)

print_quote() {
  # pick one file randomly
  local file
  file=$(shuf -n1 -e "${QUOTE_FILES[@]}")
  # pick one random line (quote) from that file
  shuf -n1 -- "$file"
}

print_quote_uniform() {
  # concatenate them and pick one random line
  cat "${QUOTE_FILES[@]}" | shuf -n1
}

# run print_quote after every command finishes
precmd_functions+=(print_quote_uniform)
