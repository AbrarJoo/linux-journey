#! /bin/bash

echo "ENTER THE NAME OF THE SCRIPT U WANT TO CREATE"
read scriptname

touch $scriptname
chmod +x $scriptname
mousepad ${scriptname}&

echo "your script has been created have fun"
