#! /bin/bash

#declare -r will create a read only file
declare -r pwdfile=/etc/passwd

echo $pwdfile

pwdfile=/etc/abc.txt

echo $pwdfile


#this variable is a read only variable (-r)
