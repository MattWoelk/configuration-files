#!/bin/bash
# This takes all of the files in path-list.txt and makes a file structure
# in the current directory and copies them into it.

# to make this cronabble
cd $(dirname $0)

#                   v-- is this middle pipe'd part even necessary...?
cat path-list.txt | xargs -I{} echo {} | cpio -pduL --quiet . 
