#! /bin/bash

count=10
if (( $count > 9 ))
then
	echo "this condition is true"
	
elif (( $count <= 9 ))
then
	echo "this condition is false"
	
else
	echo "enter the correct value"
fi
