#!/bin/bash
# This takes all of the files in path-list.txt and makes a file structure
# in the current directory and copies them into it.
# If a directory name is given in path-list.txt, the entire directory
# and all subdirectories will be copied

# to make this cronabble
cd $(dirname $0)

while read line; do
  find -L $line | cpio -pduL --quiet .
done < path-list.txt


# old method: (didn't do path names)
#cat path-list.txt | cpio -pduL --quiet . 

modprobe -c > modprobe_-c.txt
