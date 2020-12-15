#!/bin/bash
[ -f ~/.bash/env ] && source ~/.bash/env
[ -f ~/.bash/config ] && source ~/.bash/config
[ -f ~/.bash/aliases ] && source ~/.bash/aliases

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.cargo/env ] && source ~/.cargo/env

# added by travis gem
[ ! -s /Users/esak/.travis/travis.sh ] || source /Users/esak/.travis/travis.sh
