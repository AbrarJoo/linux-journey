#!/bin/bash
a=2
b=2
if [[ $a == $b ]]; then
	echo "a abd b are the same"
fi
c=4
d=3
if [[ $c != $d ]]; then
	echo "c and d are not the same"
fi

if [[ -f file.txt ]]; then
	echo "file.txt exists and is a file"
else
	echo "file.txt doesnt exist"
fi

while [[ -f file.txt ]]; do
	echo "file.txt exists and is a file"
	sleep 1
done
echo "it is done"

until [[ -f file.txt ]]; do
	echo "file.txt does not exist"
	sleep 1
done
echo "file is made"
