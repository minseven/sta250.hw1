#!/usr/bin/python

import sys
import random
import numpy

def get_length(filename):
	file=open(filename,'r')
	count=0
	for line in file.xreadlines():
		count=count+1
	return count

n=get_length(sys.argv[1])
m=int(sys.argv[2])
list=random.sample(range(0,n),m) # randomly sample the m indices from 1 to n where n is size of all observations in the csv file
data=[]

file=open(sys.argv[1],'r')
first=True
index=0
for line in file.xreadlines(): # for each line
        if first == True: # we skip the first line as it's header
		first=False
		continue
	line=line[:-1]
        element=line.split(',')
	if index in list and element[14] != 'NA': 
        	data.append(int(element[14])) # we collect the value of arrival delay
	index=index+1
# compute the statistics
print "Mean: "+str(numpy.mean(data))
print "SD: "+str(numpy.std(data))
print "Median: "+str(numpy.median(data))
