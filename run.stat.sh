#!/bin/bash

FILE=$1

if [ ! -f $FILE.ft ];
then
	sort $FILE | uniq -c | sort -k 1 -r | grep -v NA | awk '{print $1 "\t" $2}' > $FILE.ft
fi
