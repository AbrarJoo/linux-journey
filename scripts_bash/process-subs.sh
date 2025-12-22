#!/bin/bash

words=$(grep d /usr/share/dict/words)  #all words in a single variable -c gives count

i=0
for word in $words; do
	echo "$word"
	((i++))  #counting each words and thats why we dont quote words variable because it will just show up a very long string not the actual word count
done
echo "found $i words"


echo "========another way========"
#we will use a here string (<<<<) #but we donyt wanna have all these lines in our ram lets stream that data into our while loop
#words=$(grep d /usr/share/dict/words)
#i=0
#while read -r word;do
#	echo "$word"
#	((i++))
#done <<< "$words"


#echo "found $i words"
echo "======usingpipes to save resources========"

i=0

grep d /usr/share/dict/words | while read -r word; do
	echo "$word"
	((i++)) #this is working in while subshell final count is zero because global process wasnt affected to get around we use process substition
done 
echo "found $i words"

echo "========ACTUAL PROCESS SUBS========="

i=0
while read -r; do
	echo "$word"
	((i++))
done < <(grep d /usr/share/dict/words) #this process substition < < treats this whole command as a file ie <(grep d /usr/share/dict/words) gets turned into a file and to read from a file < this is always used

echo "found $i words"

























