#! /bin/bash 

number=1
while [ $number -lt 10 ]
do
	echo "$number"
	number=$(( number+1 ))
done
echo "---------------------------"
number2=1
until [ $number2 -ge 10 ]
do
	echo "$number2"
	number2=$(( number2+1 ))
done
echo "-----------------------------"

for i in 1 2 3 4 5 
do
	echo $i
done
echo "------another for loop method--------"

for i in {0..20}
do 
	echo $i
done
echo "also the increment"
for i in {0..20..2} # '{starting..ending..increment}'
do
	echo $i
done
echo "------more conventional for loop--------"
for (( i=0; i<=6; i++ )) # ''{starting..ending..increment}'
do
	echo $i
done

# 'lets study break-continue statement'
echo "---------break statement--------"
for (( i=0; i<=10; i++ ))
do
	if [ $i -gt 5 ]
	then
		break
	fi
	echo $i
done

echo "---------continue statement---------"
for (( i=0; i<=10; i++ ))
do 
	if [ $i -eq 3 ] || [ $i -eq 7 ]
	then
		continue
	fi
	echo $i
done
