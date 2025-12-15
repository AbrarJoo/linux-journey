#! /bin/bash
echo "enter directory name to check"
read direct

if [ -d "$direct" ]
then 
	echo "directory $direct exists"
else
	echo "directory $direct doesnt exist"
fi

#script to check if a directory exits -d is th key here and direct is simply a variable

#script to create a file

echo "enter the filename u want to create"
read file

touch $file

#script to check if a file exists or not

echo "enter file name to check"
read filename

if [ -f "$filename" ]
then 
	echo "file $filename exists"
else
	echo "file $filename doesnt exist"
fi


