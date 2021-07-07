#!/bin/zsh
alias be='bundle exec '

alias gs='git status '
alias gap='git add -p'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gk='gitk --all& '
alias glodag='git log --all --decorate --graph --oneline'
alias gh='git ls-files -v . | grep ^S'

alias sshfs-sdf='sshfs agarren@sdf.lonestar.org:/sdf/arpa/af/a/agarren/docs ~/mnt/sdf -o defer_permissions -o volname=Server'

alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'

# full color tmux terminal for vim colorscheme support
#alias tmux="TERM=screen-256color-bce tmux"
alias ssh='TERM=xterm-256color ssh'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder && say DNS cache flushed'

alias doco='docker-compose'
alias doco-clean='git checkout .gitignore package.json && rm $(git untracked)'
alias docker-volume-remove='docker rm $(docker ps -aq) && docker volume rm re9-agarren_node_modules'
alias vim='nvim'
alias cat='bat'
alias lsof3k='lsof -nP -i:3000'
