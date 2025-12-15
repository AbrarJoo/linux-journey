#! /bin/bash

age=5

if [ $age -gt 18 -o $age -lt 40 ]
then
	echo "age is correct"
else
	echo "age is not correct"
fi
