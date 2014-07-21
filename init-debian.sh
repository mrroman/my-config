#!/bin/sh

sudo apt-get install vim
sudo apt-get install mc zip unzip
sudo apt-get install build-essential intltool gettext libtool automake autoconf

if [ ! -d ~/src ] ; then mkdir ~/src ; fi

cd ~/src
git clone http://git.code.sf.net/p/zsh/code zsh
cd zsh
./configure --prefix=/usr/local && make && sudo make install-strip 
