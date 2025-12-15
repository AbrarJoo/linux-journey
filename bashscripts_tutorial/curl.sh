#! /bin/bash

url=""

curl ${url} -O   #means actual filename

curl $url -o newfile #this gives it a new name
curl $url > filename #this will do the same thing

curl -I $url #this will get only the header of the file
