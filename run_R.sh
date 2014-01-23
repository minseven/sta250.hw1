#!/bin/bash
#
#$ -cwd
#$ -V
#$ -j y
#$ -S /bin/bash
#$ -m e
#$ -M minseven77@gmail.com

DIR=$1
rm arrdelay.R.txt
for file in $(/bin/ls $DIR/*.csv | grep -v _)
do
	cut -d , -f 15 $file | sed '1d' | grep -v NA >> arrdelay.R.txt
done

for file in $(/bin/ls $DIR/*.csv | grep _)
do
	cut -d , -f 45 $file | sed '1d' | grep . >> arrdelay.R.txt
done
R --slave --args "arrdelay.R.txt" < run.R
