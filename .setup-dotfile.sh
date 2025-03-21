#!/bin/zsh

if command -v "apt" &> /dev/null; then
  sudo apt update -y && sudo apt upgrade -y && sudo apt-get update -y && sudo apt-get upgrade -y
  sudo apt install git
fi


alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' >> $HOME/.zshrc
echo ".cfg" >> .gitignore

git clone --bare https://github.com/GoofyCylinder57/dotfiles $HOME/.cfg

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

config checkout
config config --local status.showUntrackedFiles no

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if command -v "brew" &> /dev/null; then
  brew install $(cat .brew_leaves.txt)
fi
