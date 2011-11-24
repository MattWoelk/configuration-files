#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#--ALIASES--
alias ls='ls -l --color=auto'
alias pacman=pacman-color
alias vlc-for-remote='vlc -I http'
alias bc='bc -q'
alias info='info --vi-keys'
alias grep='grep -i --color'
alias urxvt='urxvt -bg black -fg white +sb'
alias r='ranger-cd'
alias unmount='udiskie-umount'
alias twitter='tyrs'
alias feh='feh -B black -.'

#so that I don't have to think when untarring things:
alias 'tar-tar'='tar xvf'
alias 'tar-tar.gz'='tar xvfz'
alias 'tar-tgz'='tar xvfz'
alias 'tar-tar.bz2'='tar xvfj'

#--PROMPT--
#PS1='[\u@\h \W]\$ ' #The arch default
PS1="\[\033[0;32m\][\u@\h \w]$\[\033[0m\] "

#Tab-Completion in sudo and man
complete -cf sudo
complete -cf man
complete -cf optirun


#--ENVIRONMENTAL VARIABLES--
export EDITOR="vim"

# ignore duplicates in bash history
export HISTCONTROL=ignoredups

# append history from each terminal upon exit
shopt -s histappend

# make bash history ... HUGE!
HISTSIZE=100000


#This is a bash function (for ~/.bashrc) to change the directory to the last visited one after ranger quits.  You can always type "cd -" to go back to the original one.
function ranger-cd {
  tempfile='/tmp/chosendir'
  /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

alias ranger='ranger-cd'


# Humble Bundle Keys
export _humblevoxatronkey=`cat .humblekeys/voxatron.txt`
export _humblebundle3key=`cat .humblekeys/humbleindiebundle3.txt`
