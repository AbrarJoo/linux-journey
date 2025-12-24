#!/bin/bash

set -x #bash arguments start
 
first_name='dave'
last_name='eddy'

set +x #bash argument closed

full_name="$first_name $last_name"

if [[ $first_name == 'dave' ]]; then
	echo "oh hey its dave"
fi

echo "hello $full_name"
