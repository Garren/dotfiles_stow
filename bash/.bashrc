#!/bin/bash
if [[ -f ~/.bashrc ]] ; then
    source ~/.bashrc
fi

if [[ -f ~/.profile ]] ; then 
    source ~/.profile
fi

# run when not a login shell

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Users/adamgarren/.node_packages/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
