#! /bin/bash
function funcName()
{
	echo "this is a new function"

}

funcName

#lets provide argument to the function

function funcPrint()
{
	echo $1   #this is the argument for this function
}

funcPrint hi

#LETS PASS MULTIPLE ARGUMENTS
function funcPrint()
{
	echo $1 $2 $3  #these are the argument for this function
}

funcPrint hi i am

#checking if our function works

function funcCheck()
{
	returningvalue="using this function right now"
	echo $returningvalue
}
funcCheck

#local and global value

function fnc()
{
	returningvalue="i love linux"  #local variable
}
returningvalue="i love MAC"  #global variable

echo $returningvalue #this will give outer value
fnc
echo $returningvalue #while as this will give inner value

fnc
