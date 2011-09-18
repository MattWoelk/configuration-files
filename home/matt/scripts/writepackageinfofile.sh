#!/bin/bash

PROGRAMLIST="/home/matt/programs.txt"
PROGRAMDUMP="/home/matt/programdump.temp"

yaourt -Qet | cut -d'/' -f2 | cut -d' ' -f1 > "$PROGRAMDUMP"
# PROGRAMDUMP now contains a list of all installed programs 
# and it will continue to do so for the duration of this script.

# delete the last paragraph of PROGRAMLIST
sed '/UNSORTED/ q' < "$PROGRAMLIST" > "$PROGRAMLIST".temp
cp "$PROGRAMLIST".temp "$PROGRAMLIST"

# get rid of everything from PROGRAMDUMP which is still in PROGRAMLIST
# read, line-by-line from PROGRAMDUMP
while read line; do
  #echo "$line"
  # see if the current line is in PROGRAMLIST
  cat "$PROGRAMLIST" | grep "^$line" > /dev/null
  if [ $? -ne 0 ]
  then
    # if it wasn't already in the file somewhere, add it
    # to PROGRAMLIST
    echo "$line" >> "$PROGRAMLIST"
  fi
done < "$PROGRAMDUMP"

# take the last paragraph of PROGRAMLIST and sort it
# TODO: this may no longer me necessary...
#PRESORTEDLIST=$(sed '1,/UNSORTED/ d' < "$PROGRAMLIST")
#SORTEDLIST=$(echo "$PRESORTEDLIST" | sort)
#echo "$SORTEDLIST" >> "$PROGRAMLIST"

# get rid of temp files
rm "$PROGRAMLIST".temp
rm "$PROGRAMDUMP"


# TODO TODO TODO TODO todo TODO TODO TODO TODO
# new program flow:
#   [done] delete "unsorted" paragraph from PROGRAMLIST
#   [done] take out everything from PROGRAMDUMP which is still in PROGRAMLIST
#   [done] add programdump to the end of PROGRAMLIST
#   [x] profit

#-----------------------------------------------#
#sed '/UNSORTED/ q' will print every line until (and including) UNSORTED
#sed '1,/UNSORTED/ d' will print every line after UNSORTED
