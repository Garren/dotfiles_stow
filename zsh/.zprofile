#!/bin/zsh
# zprofile is called for login shells (ssh, etc.) OSX terminal.app opens a
# login shell for every terminal. 

if [ -f ~/.zshrc ] ; then
    source ~/.zshrc
fi

if [ -s ~/.profile ] ; then 
    source ~/.profile
fi

