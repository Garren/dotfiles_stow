#!/bin/zsh
# zshrc is called for interactive non-login shells.
# for Linux and virtually all other unix/unixlikes this is when you're already
# logged in and you open another xterm, or fire up a new shell from the 
# terminal.

export TZ=:/etc/localtime
export LC_TYPE=en_US.UTF-8

# emacs mode
bindkey -e

# fix the delete key
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char


## Prompt
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT="%F{045}[%0m]%f%F{205}%~%f:%F{139}%(1j.(%j%).)%f%F{129}%?%f%F{229} \$(parse_git_branch)%f${NEWLINE}$ "
