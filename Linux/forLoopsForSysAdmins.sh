#!/bin/bash

#list of files we want to print permissions for
sensitiveFiles=(/etc/shadow /etc/passwd)

#for each file in sensitiveFiles, prints the permissions
for file in ${sensitiveFiles[@]}
do
echo "$file permissions: " 
ls -l $file | awk '{print $1}'
done

