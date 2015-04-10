#!/bin/bash

function log {
    h1color='\e[0;32m'
    h2color='\e[0;36m'
    endColor='\e[0m'

    case "$1" in
        1)
            echo -e "${h1color}$2${endColor}: $3"
            ;;
        2) 
            echo -e "${h2color}$2${endColor}: $3"
            ;;
    esac
}

function l {
    if [ ! -e ~/$2 ]
    then
        log 2 "Links" "Linking $1 to $2"
        ln -s `pwd`/$1 ~/$2
    else
        log 2 "Links" "Already installed $2"
    fi
}

function setup_zsh {
    log 1 "Setup ZSH"
    log 2 "Install OH MY ZSH"
    [ -d ~/.oh-my-zsh ] || wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

    log 2 "Set aliases"
    grep -q 'source ~/.aliases' || echo "source ~/.aliases" >> ~/.zshrc
    l aliases .aliases
}

function setup_vim {
    log 1 "Setup VIM"
    log 2 "Install Vundle"
    [ -d ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    l vimrc-vundle .vimrc

    log 2 "Install plugins"
    vim +PluginInstall +qall
}

function set_links {
    log 1 "Set configuration links"
    
    l tmux.conf .tmux.conf
    l bin .bin
}

function git_config {
    log 1 "Configure Git"
    log 2 "Git" "Set aliases"
    git config --global alias.co checkout
    git config --global alias.st status
    git config --global alias.ci commit
    git config --global alias.l "log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset'"
    git config --global alias.ll "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate --numstat"
    git config --global alias.ls "log --pretty=format:\"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]\" --decorate"
    git config --global alias.filelog "log -u"
    git config --global alias.fl "log -u"
    git config --global alias.diff "diff --word-diff"
    git config --global alias.dc "diff --cached"

    log 2 "Git" "Set credential"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=3600'
    
    log 2 "Git" "Vimdiff"
    git config --global diff.external ~/.bin/git_diff_wrapper

    log 2 "Git" "Set default push strategy to simple"
    git config --global push.default simple
}

for nm in setup_zsh setup_vim set_links git_config
do
    $nm
    echo
done
