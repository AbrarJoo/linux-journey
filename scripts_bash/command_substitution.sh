#!/bin/bash

#thing='whoami' #this will print the literal whoami and wont execute the command 
thing=`whoami`
echo "thing is $thing"

echo "======actual command substitution========="

whoami
echo "hey $(whoami)"
echo "u are using $(uname -a)"

echo "======mini===="

i=5
my_func() {
	i=6
	echo "this was printed using a mini function"
	
}
thing=$(my_func)
echo "thing is $thing"

echo "i is $i"

echo "=====lets not run myfunc in subshell but in main shell======"

i=5
my_func() {
	i=6
	echo "this was printed using a mini function"
	
}
thing=${ my_func; }   #new bash feature    
echo "thing is $thing"

echo "i is $i"
