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
# — C++ compiler and debugging configuration —
#   standard, debug info, warnings, sanitizers, STL checks
# CXX=clang++                   Use Clang as the C++ compiler
# -std=c++23                    Use the C++23 standard
# -O0                           Disable optimizations for easier debugging
# -ggdb3                        Emit full GDB debug info, including macro definitions
# -Wall -Wextra                 Enable common and additional warning checks
# -Wpedantic                    Warn about non-standard C++ extensions
# -Wconversion                  Warn about implicit conversions that may alter values
# -Wno-sign-conversion          Suppress noisy signed/unsigned conversion warnings
# -Wshadow                      Warn when a declaration shadows another variable
# -Wswitch-enum                 Warn when enum values are omitted from a switch
# -Wimplicit-fallthrough        Warn about unintended switch fallthrough
# -Wold-style-cast              Warn about C-style casts
# -fno-omit-frame-pointer       Keep frame pointers for useful backtraces
# -fsanitize=address            Detect invalid memory accesses
# -fsanitize=undefined          Detect undefined behavior
# -fsanitize=integer            Detect suspicious integer operations and conversions
# -fno-sanitize=unsigned-integer-overflow
#                               Ignore defined unsigned integer wraparound
# -fno-sanitize-recover=all     Abort immediately when a sanitizer detects an error
# -D_GLIBCXX_DEBUG              Enable libstdc++ iterator, bounds, and range checks
# ASAN_OPTIONS=detect_leaks=0   Disable leak detection, especially for GDB compatibility
# UBSAN_OPTIONS=print_stacktrace=1
#                               Print a stack trace for UBSan errors
export CXX="clang++"
export CXXFLAGS="\
-std=c++23 \
-O0 \
-ggdb3 \
-Wall \
-Wextra \
-Wpedantic \
-Wconversion \
-Wno-sign-conversion \
-Wshadow \
-Wswitch-enum \
-Wimplicit-fallthrough \
-Wold-style-cast \
-fno-omit-frame-pointer \
-fsanitize=address,undefined,integer \
-fno-sanitize=unsigned-integer-overflow \
-fno-sanitize-recover=all \
-D_GLIBCXX_DEBUG"
export ASAN_OPTIONS="detect_leaks=0"
export UBSAN_OPTIONS="print_stacktrace=1"
#export CPPFLAGS="-I/path/to/include"

# Add local installed binaries to the path.
export PATH=$HOME/.local/bin:$PATH

# https://github.com/dom96/choosenim
export PATH=$HOME/.nimble/bin:$PATH

# https://www.haskell.org/ghcup/
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

export PATH=$HOME/.cargo/bin:$PATH

# list of quotes
#local QUOTE_FILES=(~/.misato/quotes ~/.misato/nihongo ~/.misato/zhuyin)
local QUOTE_FILES=(~/.misato/hsk1_vocabulary_zhuyin.csv ~/.misato/hsk2_vocabulary_zhuyin.csv)

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

source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

alias t='todo.sh -d ~/.todo.cfg'
alias gdbtest='gdb -q -x test.gdb'
