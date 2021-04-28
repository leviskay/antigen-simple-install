#!/bin/bash

pathToAntigen="/usr/share/antigen"
scriptName="antigen.zsh"
fullPath=$pathToAntigen/$scriptName

function installZshForUser {
  user=$1
  userDir=$2
  while true; do
  # </dev/tty used to get user input when using a pipe
    read -p "Install zsh as default shell and write .zshrc for $user?[y/N] " yn </dev/tty 
    case $yn in
      [Yy]* ) break;;
      [Nn]* ) return;;
      * ) return;;
    esac
  done
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

  echo -n "Write .zshrc for $user..."
  echo "$zshrc" > $userDir/.zshrc
  echo " Success"
  echo -n "Install zsh as default shell for $user..."
  chsh -s /bin/zsh $user 
  echo " Success"
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -f $fullPath ]; 
then 
  echo "Antigen has already been download."
else
  apt install -y curl git
  mkdir -p $pathToAntigen 
  curl -L git.io/antigen > $pathToAntigen/antigen.zsh
fi

I=`dpkg -s zsh | grep "Status" ` 
if [ -n "$I" ] 
then
  echo "Zsh has already been installed."
else
  apt install -y zsh
fi

installZshForUser root /root

usersDir=$(ls /home)
for user in $usersDir
do
  installZshForUser $user /home/$user
done
