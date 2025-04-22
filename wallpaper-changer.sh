#!/bin/bash
#
# Created by djazz // Dangershy
# Dependencies: feh
#

FOLDER="/home/vicfred/img/wallpapers"
DELAY=1

# to make it loop over lines instead of spaces in filenames
IFS=$'\n';

while true; do
	LIST=`find "$FOLDER" -type f \( -name '*.jpg' -o -name '*.png' \) | shuf`
	for i in $LIST; do
		echo "$i"
		feh --bg-fill "$i" 
		sleep ${DELAY}m
	done
	sleep 1
done
