#!/bin/bash

PROGRAMLIST="/home/matt/programs.txt"
PROGRAMDUMP="/home/matt/programdump.txt"

yaourt -Qet | cut -d'/' -f2 | cut -d' ' -f1 > "$PROGRAMDUMP"

while read line; do
	#echo "$line"
	# see if the current line is in PROGRAMLIST
	cat "$PROGRAMLIST" | grep "^$line" > /dev/null
	if [ $? -ne 0 ]
	then
		echo "$line" >> "$PROGRAMLIST"
	fi
done < "$PROGRAMDUMP"

# take the last paragraph of PROGRAMLIST and sort it
PRESORTEDLIST=$(sed '1,/UNSORTED/ d' < "$PROGRAMLIST")
SORTEDLIST=$(echo "$PRESORTEDLIST" | sort)

# delete the last paragraph of PROGRAMLIST TODO: FIX THIS
sed '/UNSORTED/ q' < "$PROGRAMLIST" > "$PROGRAMLIST"2
cp "$PROGRAMLIST"2 "$PROGRAMLIST"
rm "$PROGRAMLIST"2
rm "$PROGRAMDUMP"

# add the new, sorted paragraph to PROGRAMLIST
echo "$SORTEDLIST" >> "$PROGRAMLIST"


#-----------------------------------------------#
#sed '/UNSORTED/ q' will print every line until (and including) UNSORTED
#sed '1,/UNSORTED/ d' will print every line after UNSORTED
