HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/konrad/.zshrc'

autoload -Uz compinit
compinit

clear

# Init teminal
#
[ "$TERM" = "xterm" ] && export TERM=xterm-256color

# zkbd - configuration of key bindings
#
autoload zkbd
if [ -e ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]
then
    source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
else
    #echo "Please set up keyboard"
    #zkbd
    #source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
fi

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# Colors and VCS
#
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "(%{$fg[green]%}%b%{$reset_color%})"
zstyle ':vcs_info:*' enable git hg
zstyle ":vcs_info:*" unstagedstr "%{$fg_bold[green]%}!%{$reset_color%}"
zstyle ":vcs_info:*" stagedstr "%{$fg_bold[yellow]%}+%{$reset_color%}"

precmd() {
    vcs_info
}

setopt prompt_subst
PROMPT=' %{$fg[yellow]%}%~%{$reset_color%}${vcs_info_msg_0_} %# '

. ~/.bin/z/z.sh
. ~/.aliases

export PATH="$HOME/.bin:$PATH"

#if [ -z $TMUX ] 
#then
#    echo
#    [ -e ~/.motd ] && cat ~/.motd | sed 's/^/    /'
#fi

# no delay entering normal mode
# https://coderwall.com/p/h63etq
# https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# 10ms for key sequences
KEYTIMEOUT=1

# show vim status
# http://zshwiki.org/home/examples/zlewidgets
#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/$fg_bold[yellow]I$reset_color}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# add missing vim hotkeys
# fixes backspace deletion issues
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
bindkey -M viins '^s' history-incremental-search-backward
