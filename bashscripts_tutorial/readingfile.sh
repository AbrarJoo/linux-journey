#! /bin/bash

while read line
do 
	echo "$line"
done < "${1:-/dev/stdin}"  
#without an argument it would reciv the input and give it back as output without changing anything

#but providing a filename in the directory it will give the output and read the file via stdin
