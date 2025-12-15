#! /bin/bash
echo "press any key to continue"

while [ true ]
do
	read -t 3 -n 1     #t means seconds and after every 3 seconds it will print a statemnt

if [ $? = 0 ]
then 
	echo " you have terminated the script"
	exit;
else
	echo "waiting for you to press the key sir"
fi

done
