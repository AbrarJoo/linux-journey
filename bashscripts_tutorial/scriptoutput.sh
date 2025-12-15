#! /bin/bash

ls -al 1>file1.txt 2>file2.txt

#this is script output and the two files will be created one SDOUT that is it will recieve the output and SDERROR and the other will recieve the error (if any) if there are no errors the secod file would be empty

#if only one file as below it would be assumed as a standard output file only but not standard error file and it will give the error on the terminal instead

ls -al > file3.txt

#now to put both the things in one file do the below

ls -al > file4.txt 2>&1
#and there is a shortcut for thsi too

ls -al >& file5.txt
