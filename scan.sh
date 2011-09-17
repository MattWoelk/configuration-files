#!/bin/bash

#echo /etc/rc.conf | cpio -pd .

#if [[ `echo $"one"` -eq 1 ]]; then echo two; fi

#cat path-list.txt | xargs -I{} echo {}

#cat path-list.txt | xargs -I{} if [[ `echo {} | head -c 2` -eq '~/' ]]; then echo {}; fi

cat path-list.txt | xargs -I{} if [[ $( echo {} ) -eq '~/.Xdefaults' ]]; then echo {}; fi
