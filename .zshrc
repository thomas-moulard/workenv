#!/usr/bin/zsh
if test -f "$HOME/.workenv/workenv.zsh"; then
 source $HOME/.workenv/workenv.zsh
else
 echo "failed to load workenv"
fi
