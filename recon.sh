#!/bin/bash

mkdir $1
cd $1
echo "Finding subdomains for " $1

echo $1 | assetfinder --subs-only > $1.asset.txt | amass enum --passive -d $1 > $1.amass.txt  | sublist3r  -d $1  -o $1.subl.txt
cat $1.asset.txt $1.subl.txt $1.amass.txt | sort | uniq > subdomain.txt
echo "Running httprobe for active subdomains"
cat subdomain.txt | httprobe > httprobe.txt
echo "screenshots for active domains"
python3 /root/tools/EyeWitness/EyeWitness.py --no-prompt  -f httprobe.txt --web -d eye

