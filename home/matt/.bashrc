#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#--ALIASES--
alias ls='ls --color=auto'
alias pacman=pacman-color
alias vlc-for-remote='vlc -I http'
alias bc='bc -q'
alias info='info --vi-keys'

#--PROMPT--
#PS1='[\u@\h \W]\$ ' #The arch default
PS1="\[\033[0;32m\][\u@\h \w]$\[\033[0m\] "

#Tab-Completion in sudo and man
complete -cf sudo
complete -cf man


#--ENVIRONMENTAL VARIABLES--
export EDITOR="vim"
