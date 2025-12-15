#! /bin/bash
echo 21+21
 #this will just return the string not add
 
 n1=21
 n2=4
 
 echo $(( n1+n2 ))
 echo $(( n1-n2 ))
 echo $(( n1*n2 ))
 echo $(( n1/n2 ))
 echo $(( n1%n2 ))
 
#now this will add the numbers but it wont give back the float just the integer

#now this can also be achieved with expr command

echo $(expr $n1 + $n2 )
echo $(expr $n1 / $n2 )
echo $(expr $n1 \* $n2 )
echo $(expr $n1 % $n2 )
echo $(expr $n1 - $n2 )
#expr doesnt understand * so add\ befor it

#now converting hexadecimal to a decimal number

echo " enter a hex number of ur choice"
read Hex

echo -n "the decimal value of $Hex is; "

echo "obase=10; ibase=16; $Hex" | bc #bc calculater is being used to perform




