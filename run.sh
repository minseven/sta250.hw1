#!/bin/bash

DIR=$1 # The directory containing all csv files
rm arrdelay.txt
for file in $(/bin/ls $DIR/*.csv | grep -v _) # for the csv files having arrival delay on 15th field
do
	cut -d , -f 15 $file | sed '1d' | grep -v NA >> arrdelay.txt # concatenate the lines of the field into one file
done

for file in $(/bin/ls $DIR/*.csv | grep _) # for the csv files having arrival delay on 45th field
do
	cut -d , -f 45 $file | sed '1d' | grep . >> arrdelay.txt # concatenate the lines of the field into one file
done
R --slave --args "arrdelay.txt" < run.R # measure mean/std/med from arrdelay.txt
