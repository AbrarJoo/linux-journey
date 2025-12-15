#! /bin/bash

select car in BMW TESLA ROVER TOYOTA
do 
	case $car in 
	BMW)
		echo "BMW selected";;
	TESLA)
		echo "TESLA selected";;
	ROVER)
		echo "ROVER selected";;
	TOYOTA)
		echo "TOYOTA selected";;
	*)
		echo "ERROR please select between 1 to 5";;
	esac
done 
