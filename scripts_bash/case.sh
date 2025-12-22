#!/bin/bash

s=$1
case "$s" in
	dave)
		echo hi dave
		;;
	buddy)
		echo hey buddy
		;;
	guy)
		echo hey guy u
		;;
	*) #a wildcard
		echo idont know who u are
		;;
esac
	
 
