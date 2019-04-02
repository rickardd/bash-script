#! /bin/bash
echo $0 $1 $2 
url=$1
name=$2


if [ "$url" != "" ]
then
	echo "${name} --- ${url}" >> ~/Desktop/links_collection.sh
else
	clear
	cat ~/Desktop/links_collection.sh
fi
            
