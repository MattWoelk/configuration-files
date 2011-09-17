#!/bin/bash
# This takes all of the files in path-list.txt and makes a file structure
# in the current directory and copies them into it.

cat path-list.txt | xargs -I{} echo {} | cpio -pduL --quiet . 
