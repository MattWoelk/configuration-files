#!/bin/bash
# This takes all of the files in path-list.txt and makes a file structure
# in the current directory and copies them into it.

# to make this cronabble
cd $(dirname $0)

cat path-list.txt | cpio -pduL --quiet . 
