#! /bin/bash 

echo "enter filename u want to print from awk"
read filename

if [ -f $filename ]
then 
	awk '/linux/ {print $2,$4}' $filename    #linux is the word we wanted to find
						#$2 prints second field on the line which 					contains linux WORD
else
	echo "file doesnt exist"
fi
