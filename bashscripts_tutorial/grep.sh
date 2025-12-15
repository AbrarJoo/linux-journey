#! /bin/bash
echo "enter filename to search text from"
read filename

if [ -f $filename ]
then 
	echo "file exists"
	echo "enter the text to search"
	read grepvar
	grep $grepvar $filename #word and filename  #i is case insensitive #n gives line number # and c gives the total occurances  #and v gives all lines without that particular word [-i -n -v -c]
else
	echo "file doesnt exist"
fi


