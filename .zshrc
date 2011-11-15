#!/usr/bin/zsh
if test -f "~/.workenv/workenv.zsh"; then
 source ~/.workenv/workenv.zsh
else
 echo "failed to load workenv"
fi
