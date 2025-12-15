#! /bin/bash

echo "enter the file u want to delete"
read filename

if [ -f $filename ]
then 
	rm -rf $filename
	echo "deletion successful"
else
	echo "file doesnt seem to exist"
fi
