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
precmd() {
	vcs_info
}

setopt prompt_subst
PROMPT='%{$fg[yellow]%}%~%{$reset_color%}${vcs_info_msg_0_} %# '
