# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/konrad/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

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

clear 
if [ -z $TMUX ] 
then
    echo
    [ -e ~/.motd ] && cat ~/.motd | sed 's/^/    /'
fi

[ "$TERM" = "xterm" ] && export TERM=xterm-256color

bindkey -v

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
bindkey -M vicmd '^s' history-incremental-search-backward
