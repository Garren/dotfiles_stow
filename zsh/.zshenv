#!/bin/zsh

export EDITOR="vim"
export VISUAL="vim"
export ESHELL=/bin/zsh

export SSLKEYLOGFILE=~/.ssl-key.log


if which nvim >/dev/null; then
  export VISUAL="nvim"
  export EDITOR="vim"
  export VIMCONFIG=~/.config/nvim
  export VIMDATA=~/.local/share/nvim

  alias vim=nvim
  alias vi=nvim
else
  export VIMCONFIG=~/.vimrc
  export VIMDATA=~/.vim
fi

# GO
if which go >/dev/null; then
  # Set the path to the compiler and tooling. Not necessary anymore, but
  # still used in older documentation
  # https://www.digitalocean.com/community/tutorials/understanding-the-gopath
  if which brew>/dev/null; then
    export GOROOT="$(brew --prefix golang)/libexec"
  fi

  # Set the root path of a single go workspace
  # https://golang.org/doc/code.html#Workspaces
  export GOPATH=$HOME/go
  # export GOPATH=$HOME/.go

  # assume recent version of go
  export GO111MODULE=auto
  export PATH=$PATH:${GOPATH//://bin:}/bin:${GOROOT//://bin:}/bin
fi

# NODE
if which node >/dev/null && which npm >/dev/null; then
  if [ -d $HOME/.node_packages ]; then
    export NPM_PACKAGES=$HOME/.node_packages
    npm config --no-update-notifier set prefix $NPM_PACKAGES

    export NODE_PATH=$NPM_PACKAGES:$NODE_PATH
    export PATH=$NPM_PACKAGES/bin:$PATH
  else
    export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
    export PATH=/usr/local/lib/node_modules/bin:$PATH
  fi
fi

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:${JAVA_HOME}/bin

if which fzf>/dev/null; then

  if which rg>/dev/null; then
    FZF_DEFAULT_COMMAND='rg --files'
  elif which fd>/dev/null; then
    FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.sass-cache,.node_modules,build,log,.DS_Store} --type f"
  else
    FZF_DEFAULT_COMMAND='git ls-files'
  fi

  export FZF_DEFAULT_COMMAND
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
fi

if [ -d $(python3 -m site --user-base) ]; then
  PATH=$PATH:"$(python3 -m site --user-base)"/bin
fi

# Set PATH
export PATH=$PATH:$HOME/bin

# HOMEBREW
[ -d "/usr/local/sbin" ] && export PATH=/usr/local/sbin:$PATH
[ -d "/usr/local/bin" ] && export PATH=/usr/local/bin:$PATH

[ -f ~/.secrets/env ] && source ~/.secrets/env
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo/env ] && source ~/.cargo/env
