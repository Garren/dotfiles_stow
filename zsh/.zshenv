#!/bin/zsh
export EDITOR="vim"

# Set PATH
export PATH=$PATH:$HOME/bin

# HOMEBREW
if [ -d "/usr/local/sbin" ]; then
  export PATH=/usr/local/sbin:$PATH
fi
if [ -d "/usr/local/bin" ]; then
  export PATH=/usr/local/bin:$PATH
fi

# Elixir/Erlang
# Enable shell history for elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# GO 
if which go >/dev/null; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# NODE
if [ -d $HOME/.node_packages ]; then
  export NODE_PATH=$HOME/.node_packages:$NODE_PATH
  export PATH=$HOME/.node_packages/bin:$PATH
else
  export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
  export PATH=/usr/local/lib/node_modules/bin:$PATH
fi

# RUBY
if which ruby >/dev/null && which gem >/dev/null; then
  export PATH=$PATH:"$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

# SML
if which sml >/dev/null && which brew > /dev/null; then
  export PATH=/usr/local/smlnj/bin:"$PATH"
  #export PATH=$PATH:"/usr/local/Cellar/smlnj/$(brew list --versions smlnj | tr ' ' '\n' | tail -1)/bin"
fi

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:${JAVA_HOME}/bin

# RUST
if which cargo>/dev/null; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

export ESHELL=/bin/zsh
