#!/bin/bash

source ./lib/subshells.sh || exit 1

name='buddy'

echo "before name = $name"
greet dave
echo "after name = $name"


#in this the global scope of variable was chnaged as expected to fix that we can either use local keyword in our source code or using parens instead of curly braces inside the fuction syntax
