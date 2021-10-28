#!/bin/bash

if [ ! -d ~/research ]
then mkdir ~/research
fi
if [ -f ~/research/sys_info.txt ]
then rm ~/research/sys_info.txt
fi
ls -l | grep rwxrwxrwx >> ~/research/sys_info.txt
ps aux --sort %mem | head >> ~/research/sys_info.txt
