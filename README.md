## About
Simple script for download and install latest [antigen](https://github.com/zsh-users/antigen) for **zsh**.

Script download antigen in **/usr/share/antigen** folder, install **zsh** in system, install zsh and write default *.zshrc* file to users (optionally).

## Usage
> ### Work only with Debian based linux distribution!

Run in terminal
```sh
curl https://raw.githubusercontent.com/leviskay/antigen-simple-install/main/antigen-simple-install.sh | bash
```
or 
```sh
wget -q -O - https://raw.githubusercontent.com/leviskay/antigen-simple-install/main/antigen-simple-install.sh | sudo bash
```

## .zshrc template
```
source /usr/share/antigen/antigen.zsh 
antigen use oh-my-zsh
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen theme terminalparty
antigen apply
```
