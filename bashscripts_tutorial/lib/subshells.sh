#!/bin/bash

greet () (
	name=$1
	echo "hello $name"
)

goodbye() (
	name=$1
	echo "goodbye $name"
)

if ! (return 2>/dev/null); then
	#we are being called directly
	greet dave
	goodbye john
fi

#remember curly braces run in the main shell and the parens run in their own subshell orr just use local keyword before declaring variable inside the funtion syntax
