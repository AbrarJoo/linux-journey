#! /bin/bash

echo "enter filename u want to append into "
read filename

if [ -f "$filename" ]
then 
	echo "file $filename exists"
	echo "enter the text u want to append"
	read filetext
	echo $filetext >> $filename
	echo "deed is done"
	echo ""$filetext" was appended to $filename"
else
	echo "file $filename doesnt exist"
fi

cat $filename
