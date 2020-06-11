#!/bin/bash

if [ $# -eq 0 ]; then
 echo "No arguments provided";
 echo "Enter subdomain file as argument"
 exit 1
fi

echo "Argument should be subdomain files!!!!"
cat $1 | waybackurls > wayback.txt
cat wayback.txt | grep "\.js" | uniq | sort > wayback_jsfiles.txt
cat wayback_jsfiles.txt | hakcheckurl | grep "200"  > active js.txt




 

