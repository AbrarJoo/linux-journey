#! /bin/bash
args=("$@")   #'$@ means unlimited arguments/inputs'

echo ${args[0]} ${args[1]} ${args[2]} ${args[3]}
	

# these are indexs for the array named args 
#and in order to dispaly all arguments echo $@'

echo $@ "prints all inputs"

echo $# "length of the array"
