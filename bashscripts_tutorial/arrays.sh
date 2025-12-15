#! /bin/bash
 #array of cars
 
 cars=('BMW' 'TOYOTA' 'HONDA' 'fz')
 unset cars[2] #remove an element
 cars[2]='mercedes' #replace or add another vaue
 echo ${cars[@]}
 echo ${cars[2]}
 echo ${!cars[@]}
 echo ${#cars[@]}

#the exclaimation mark will just give u the indexes and nothing else
#and the # sign will give the total number of values

