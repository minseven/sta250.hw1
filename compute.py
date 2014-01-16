#!/usr/bin/python

import sys
import math

file=open(sys.argv[1],'r')
num=0
total=0
for line in file.xreadlines():
	element=line[:-1].split('\t')
	total=total+float(element[0])*float(element[1])
	num=num+float(element[0])	
mean=total/num
print total 
print num
print "mean "+str(mean)
file=open(sys.argv[1],'r')
std=0
csize=float(0)
median=0
for line in file.xreadlines():
	element=line[:-1].split('\t')
	if csize < num/float(2) and num/float(2) <= csize+float(element[0]):
		median=element[1]
	std=std+(float(element[1])-mean)*float(element[0])
	csize=csize+float(element[0])
print std
print num
print "std "+str(math.sqrt(std/num))
print "median "+median
