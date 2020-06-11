#!/bin/bash



mkdir $1
cd $1
echo "Finding subdomains for " $1

echo $1 | assetfinder --subs-only > $1.asset.txt | amass enum --passive -d $1 > $1.amass.txt  | sublist3r  -d $1  -o $1.subl.txt
cat $1.asset.txt $1.subl.txt $1.amass.txt | sort | uniq > subdomain.txt
cat subdomain.txt | httprobe > httprobe.txt
webscreenshot -i httprobe.txt -o screen

