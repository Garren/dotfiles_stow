#!/bin/bash
# run when not a login shell
if [[ -f ~/.bash_profile ]] ; then
    source ~/.bash_profile
fi

if [[ -f ~/.profile ]] ; then 
    source ~/.profile
fi

