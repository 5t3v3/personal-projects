#!/bin/bash

if [ $# -eq 0 ]; then
 echo "No arguments provided"
 exit 1
fi
mkdir $1
cd $1
echo "Finding subdomains for " $1

# Subdomain Enumeration

assetfinder --subs-only $1  > $1.asset.txt 
amass enum --passive -d $1 > $1.amass.txt 
sublist3r  -d $1 -o $1.subl.txt

#Removing duplicates and sorting
cat $1.asset.txt $1.subl.txt $1.amass.txt | sort | uniq > subdomain.txt
echo "Running httprobe for active subdomains"

#Looking for active domains
cat subdomain.txt | httprobe > httprobe.txt

#Screenshots
echo "screenshots for active domains"
python3 /root/tools/EyeWitness/EyeWitness.py --no-prompt  -f httprobe.txt --web --timeout 14 -d eye

