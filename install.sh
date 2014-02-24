#!/bin/sh

function l() {
	if [ ! -e ~/$2 ]
	then
		echo "Links: Linking $1 to $2"
		ln -s `pwd`/$1 ~/$2
	else
		echo "Links: Already installed $2"
	fi
}

echo
echo "Set configuration links:"
l zshrc .zshrc
l aliases .aliases
l vimfiles .vim
l vimrc .vimrc
l tmux.conf .tmux.conf
l bin .bin

echo
echo "Configure Git:"
echo "Git: set aliases"
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.ci commit

echo "Git: set credential"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

