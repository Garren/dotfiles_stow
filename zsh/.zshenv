#!/bin/zsh
export EDITOR="vim"

# OSX locate doesn't play well with emacs/helm. Use locate
# from gnu findutils instead if it exists
if [ -d "/usr/local/opt/findutils/libexec/gnubin" ]; then
  export PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
fi

# Set PATH
export PATH=$PATH:$HOME/bin

# HOMEBREW
if [ -d "/usr/local/sbin" ]; then
  export PATH=/usr/local/sbin:$PATH
fi

# GO
if which go >/dev/null; then
  export GO111MODULE=on
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

if [ -d $HOME/Library/Python/3.9/bin ]; then
  export PATH=$PATH:$HOME/Library/Python/3.9/bin
fi

# SML
if which sml >/dev/null && which brew > /dev/null; then
  export PATH=/usr/local/smlnj/bin:"$PATH"
fi

export JAVA_HOME=$(/usr/libexec/java_home -v 13.0.1)
export PATH=$PATH:${JAVA_HOME}/bin

# RUST
if which cargo>/dev/null; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# disable dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1 

