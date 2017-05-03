#!/bin/bash
if [[ -f ~/.bashrc ]] ; then
    source ~/.bashrc
fi

if [[ -s ~/.profile ]] ; then 
    source ~/.profile
fi
