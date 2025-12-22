#!/bin/bash

s='far'

case "$s" in
	d*) echo 'matched d*';&
	dave) echo 'macthed dave';&
	f*) echo 'matched f*';&
	foo) echo 'matched foo';&
	*) echo 'matched *';&
esac

# using ;; in case statements will only match one and stop but using ;& will match one and keeps going the statement will not break 

#using ;;& will sort of do both
