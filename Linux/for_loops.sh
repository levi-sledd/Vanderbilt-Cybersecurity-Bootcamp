#!/bin/bash

faveStates=('Pennsylvania' 'Arizona' 'Washington' 'California' 'Vermont')

HawaiiRules=false

for state in ${faveStates[@]}
do 
	if [ state == 'Hawaii' ];
	then $HawaiiRules = true 
	fi
done

if [ HawaiiRules ]
then echo 'Hawaii is the best!'
else echo "I'm not fond of Hawaii"
fi

