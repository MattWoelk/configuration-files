#!/bin/bash
# this script depends on imagemagick (or perhaps graphicsmagick) and tesseract both being installed.
echo now converting file $1 to text which will be in file $1.txt
convert $1 $1.png
tesseract $1.png $1
