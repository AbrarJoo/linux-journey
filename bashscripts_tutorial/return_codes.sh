#!/bin/bash

#uname    #this will give output 
#echo $?  #while as  this will give return code

var=$(uname)
code=$?

echo "output=$var,return code=$code"


#runing our own program inside it doesnt always have to be a command
my_func() {
	echo 'ABRAR'
	return 256  #an 8 bit number
}

var2=$(my_func)
code2=$?  #give return code from line 15

echo "output=$var2,return code=$code2"

#always put put $? under the command u want the return code for and dont put it in random places inside your script

my_func2() {
	echo 'this goes to stdout' >&1
	echo 'this goes to stderr' >&2
	return 0
}


var3=$(my_func2 2>/dev/null)   
code3=$?

echo "output=$var3,return code=$code3"
#dev/null means to throw stuff in trash 1 means throwing the output or stdout and 2 means throwing the error or stderr or doing 2>1&1 means sending them to the same place







