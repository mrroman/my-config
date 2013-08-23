#!/bin/sh

function l() {
	if [ ! -e ~/$2 ]
	then
		echo "Linking $1 to $2"
		ln -s `pwd`/$1 ~/$2
	else
		echo "Already installed $2"
	fi
}

l zshrc .zshrc
l aliases .aliases
l vimfiles .vim
l vimrc .vimrc
l tmux.conf .tmux.conf
l bin .bin

