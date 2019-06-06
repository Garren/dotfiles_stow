#!/bin/zsh
# zshrc is called for interactive non-login shells.
# for Linux and virtually all other unix/unixlikes this is when you're already
# logged in and you open another xterm, or fire up a new shell from the 
# terminal.

[ -f ~/.zsh/env ] && source ~/.zsh/env
[ -f ~/.zsh/config ] && source ~/.zsh/config
[ -f ~/.zsh/aliases ] && source ~/.zsh/aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo/env ] && source ~/.cargo/env
