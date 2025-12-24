#!/bin/bash

#greet () {
#	echo "hello $1"
#}
#
#goodbye() {
#	echo "goodbye $1"
#}	we are gonna remove the functions because they are already in our lib/greeting file and now we will source or import them. source and dot(.) work the same in bash byt differ in zsh shell

#source ./lib/greetings || exit 1 

#all this sourcing can be done by specifying a directory

libdirs=./lib

source -p "$libdirs" greetings || exit 1  #doing this bash will look inside the lib folder and execute the file greetings in which our functions are defined

greet dave
greet john 
goodbye buddy
