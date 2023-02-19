#!/bin/zsh

export EDITOR="vim"
export VISUAL="vim"
export ESHELL=/bin/zsh

# Elixir/Erlang
# Enable shell history for elixir
export ERL_AFLAGS="-kernel shell_history enabled"

[ -d /opt/homebrew/bin ] && PATH=$PATH:/opt/homebrew/bin && eval "$(/opt/homebrew/bin/brew shellenv)"

[ -d $HOME/bin ] && PATH="$PATH:$HOME/bin"
[ -d "/usr/local/sbin" ] && PATH=/usr/local/sbin:$PATH
[ -d "/usr/local/bin" ] && PATH=/usr/local/bin:$PATH
[ -d "/usr/local/protobuf/bin" ] && PATH="$PATH:/usr/local/protobuf/bin"
[ -d $HOME/.cargo/bin ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d $HOME/go/bin ] && PATH="$HOME/go/bin:$PATH"
[ -d $HOME/.emacs.d/bin ] && PATH="$HOME/.emacs.d/bin:$PATH"
[ -d $HOME/.roswell ] && PATH="$HOME/.roswell/bin:$PATH"
[ -d /usr/local/opt/llvm/bin ] && PATH="$PATH:/usr/local/opt/llvm/bin"
[ -d /opt/homebrew/anaconda3/bin ] && PATH=/opt/homebrew/anaconda3/bin:$PATH
[ -d /usr/local/texlive/2021basic/bin/universal-darwin ] && PATH="$PATH:/usr/local/texlive/2021basic/bin/universal-darwin"
[ -d $HOME/Library/Python/3.8/bin ] && PATH="$PATH":$HOME/Library/Python/3.8/bin
[ -d $HOME/.local/bin ] && PATH="$PATH":$HOME/.local/bin
[ -d /usr/local/smlnj/bin ] && PATH=$PATH:/usr/local/smlnj/bin
[ -d $HOME/.dotnet/tools ] && PATH="$PATH:/Users/adamgarren/.dotnet/tools"

export DOTNET_ROOT="$(brew --prefix)/opt/dotnet/libexec"

if which nvim >/dev/null; then
  export VISUAL="nvim"
  export EDITOR="vim"
  export VIMCONFIG=$HOME/.config/nvim
  export VIMDATA=$HOME/.local/share/nvim

  alias vim=nvim
  alias vi=nvim
else
  export VIMCONFIG=$HOME/.vimrc
  export VIMDATA=$HOME/.vim
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
  PATH=$PATH:${GOPATH//://bin:}/bin:${GOROOT//://bin:}/bin
fi

# NODE
if which node >/dev/null && which npm >/dev/null; then
  if [ -d $HOME/.node_packages ]; then
    export NPM_PACKAGES=$HOME/.node_packages
    npm config set update-notifier false
    npm config set prefix $NPM_PACKAGES

    export NODE_PATH=$NPM_PACKAGES:$NODE_PATH
    PATH=$NPM_PACKAGES/bin:$PATH
  else
    export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
    PATH=/usr/local/lib/node_modules/bin:$PATH
  fi
fi

export JAVA_HOME=$(/usr/libexec/java_home)
PATH=$PATH:${JAVA_HOME}/bin

[ -f $HOME/.secrets/env ] && source $HOME/.secrets/env
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

if which fzf>/dev/null; then

  if which rg>/dev/null; then
    FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g"!{node_modules,.git,.DS_Store}"'
  elif which fd>/dev/null; then
    FZF_DEFAULT_COMMAND="fd --exclude={.git,.idea,.sass-cache,.node_modules,build,log,.DS_Store} --type f"
  else
    FZF_DEFAULT_COMMAND='git ls-files'
  fi

  export FZF_DEFAULT_COMMAND
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
fi

export PATH
