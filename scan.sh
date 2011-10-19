#!/bin/bash
# This takes all of the files in path-list.txt and makes a file structure
# in the current directory and copies them into it.

# to make this cronabble
cd $(dirname $0)

cat path-list.txt | cpio -pduL --quiet . 
#cat path-list.txt | find | cpio -pduL --quiet . 
#                     ^-- find should repeat any file name, and list all subitems of a directory
# THIS WILL BREAK THE DIRECTORY CURRENTLY (not sure why...)
