#! /bin/bash

echo "enter first string"
read st1

echo "read second string"
read st2

if [ "$st1" == "$st2" ]
then
	echo "both strings match"
else
	echo "strings dont match"
fi

#this was string processing

# \< or \> and \= is used to compare length of strings

if [ "$st1" \< "$st2" ]
then
	echo "$st1 is smaller in length than $st2"
	
elif [ "$st1" \= "$st2" ]
then
	echo "$st1 and $st2 are equal in length"
	
else
	echo "$st1 is larger in length than $st2"
fi

#combinng or concatenate the two strings

c="$st1$st2"
echo $c 

#displaying in lowercase
echo ${st1^}
echo ${st2^^}

#inorder to change the case of the first letter we need to mention that letter after ^ and it will upcase all occurances for that letter

echo ${c^^a}
