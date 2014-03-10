#!/bin/sh


function log()
{
    h1color='\e[0;32m'
    h2color='\e[0;36m'
    endColor='\e[0m'

    case "$1" in
        1)
            echo "${h1color}$2${endColor}: $3"
            ;;
        2) 
            echo "${h2color}$2${endColor}: $3"
            ;;
    esac
}

function l() 
{
    if [ ! -e ~/$2 ]
    then
        log 2 "Links" "Linking $1 to $2"
        ln -s `pwd`/$1 ~/$2
    else
        log 2 "Links" "Already installed $2"
    fi
}

function set_links
{
    log 1 "Set configuration links"
    l zshrc .zshrc
    l aliases .aliases
    l vimfiles .vim
    l vimrc .vimrc
    l tmux.conf .tmux.conf
    l bin .bin
}

function git_config
{
    log 1 "Configure Git"
    log 2 "Git" "Set aliases"
    git config --global alias.co checkout
    git config --global alias.st status
    git config --global alias.ci commit
    git config --global alias.l "log --graph --pretty=format:'%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset'"
    git config --global alias.ll "!git l --all"

    log 2 "Git" "Set credential"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=3600'
    
    log 2 "Git" "Vimdiff"
    git config --global diff.external ~/.bin/git_diff_wrapper
}

for nm in set_links git_config
do
    $nm
    echo
done
