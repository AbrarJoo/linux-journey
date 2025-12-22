#!/bin/bash
array=(foo bar baz)
echo "1:${array[1]}"
echo "all:${array[@]}"

idx=2
echo "idx= ${array[idx]}"

echo "*- = ${array[*]}"

echo "loop over *"

for item in "${array[*]}";do
	echo "item is: $item"
done

echo "looping over @"
for item in "${array[@]}";do
	echo "item is: $item"
done


echo "--------IMP-------"
first_array=(
	foo
	bar
	baz
	jey
)

second_array=("${first_array[@]}")
second_array+=(john buddy cena)

for item in "${second_array[@]}";do
	echo "item is: $item"
done

echo "${#second_array[@]}"

#using ifs to stringify 
echo "=========IFS========"
third_array=(
	foo
	bar
	baz
	jey
)
IFS=,hello  #now the array  will be separated by the first chracter of hello or any other value assigned to the variable IFS ,  but its always used on * because that gives a string @loops so its not recommended
echo "array is: ${third_array[*]}"


#by default ifs is set to a space,new line and tab characters
