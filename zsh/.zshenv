#!/bin/zsh
export EDITOR="nvim"

# OSX locate doesn't play well with emacs/helm. Use locate
# from gnu findutils instead if it exists
if [ -d "/usr/local/opt/findutils/libexec/gnubin" ]; then
  PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
fi

# Set PATH
PATH=$PATH:$HOME/bin

# HOMEBREW
if [ -d "/usr/local/sbin" ]; then
  PATH=/usr/local/sbin:$PATH
fi

# GO
if which go >/dev/null; then
  export GO111MODULE=on
  export GOPATH=$HOME/go
  PATH=$PATH:$GOPATH/bin
fi

# NODE
if [ -d $HOME/.node_packages ]; then
  export NODE_PATH=$HOME/.node_packages:$NODE_PATH
  PATH=$HOME/.node_packages/bin:$PATH
else
  export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
  PATH=/usr/local/lib/node_modules/bin:$PATH
fi

# RUBY
if which ruby >/dev/null && which gem >/dev/null; then
  PATH=$PATH:"$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

if [ -d $HOME/Library/Python/3.9/bin ]; then
  PATH=$PATH:$HOME/Library/Python/3.9/bin
fi

# SML
if [ -d /usr/local/smlnj/bin ]; then
  PATH=/usr/local/smlnj/bin:"$PATH"
fi

export JDK_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=${JDK_HOME}
PATH=$PATH:${JDK_HOME}/bin

# RUST
if which cargo>/dev/null; then
  PATH="$HOME/.cargo/bin:$PATH"
  export CARGO=$HOME/.cargo/bin/cargo
  export CARGO_HOME=$HOME/.cargo/bin
fi

# disable dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1 
if [ -d $HOME/.dotnet/tools ]; then
  PATH="$PATH:$HOME/.dotnet/tools"
fi

export PATH
