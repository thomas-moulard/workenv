#!/bin/sh

if test -f "$HOME/.zshrc"; then
 echo "$HOME/.zshrc exists, setup won't run if this file exists."
 return 1
fi

if test -f "$HOME/.identity.zsh"; then
 echo "$HOME/.identity.zsh exists, setup won't run if this file exists."
 return 1
fi

if ! test -f `pwd`/.identity.zsh.example; then
 echo "please run the script from your workenv directory, i.e. ./setup.sh"
fi

cp `pwd`/.identity.zsh.example $HOME/.identity.zsh
ln -s `pwd`/.zshrc $HOME/.zshrc
echo "setup succeed"
