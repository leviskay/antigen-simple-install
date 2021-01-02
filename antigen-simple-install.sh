#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

pathToAntigen="/usr/share/antigen"
scriptName="antigen.zsh"
fullPath=$pathToAntigen/$scriptName

if [ -f $fullPath ]; then 
  echo "Antigen has already been installed"
  echo "Exit"
  exit
fi

apt install -y curl zsh
mkdir -p $pathToAntigen 

curl -L git.io/antigen > $pathToAntigen/antigen.zsh
zshrc="source $fullPath 
antigen use oh-my-zsh
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme terminalparty
antigen apply"

echo "Write .zshrc for root..."
echo "$zshrc" > /root/.zshrc
echo "Success"
echo "Install zsh as default shell for root..."
chsh -s /bin/zsh root
echo "Success"