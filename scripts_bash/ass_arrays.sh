#!/bin/bash

#key value declare usage 

declare -A arr

arr[foo]=1
arr[bar]=2
arr[baz]=3

echo "${arr[foo]}"
echo "${arr[bar]}"
echo "${arr[baz]}"

echo "${arr[*]}"  #they will loop over the values not keys
echo "${arr[@]}"

echo "${!arr[@]}"  #the exclaimation means act on keys not values


for key in "${!arr[@]}";do
	value=${arr[$key]}
	echo "got key ; $key=$value"  #gives nothing so use dollar sign on keys
done
