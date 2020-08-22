#!/bin/bash

# https://github.com/US-CBP/GTAS/issues/1175
# apt install jq sed
# remove double quote  awk '{gsub(/"/,"")};1' red-notices.csv > output.csv

DATEEXT=`date --utc +%FT%T.%3NZ`
resultPerPage=8000

if [ -n "$1" ]; then
	resultPerPage=$1
else
	json=$(curl -s https://ws-public.interpol.int/notices/v1/red?resultPerPage=1)
	resultPerPage=$( jq -r '.total' <<< "${json}" )

fi

echo -e "\nDownloading $resultPerPage red notices\n "

curl -o red-notices.json https://ws-public.interpol.int/notices/v1/red?resultPerPage=$resultPerPage

echo "forename,date_of_birth,entity_id,nationalities,name,interpol_link,interpol_imagesi,no,type" > red-notices.csv

jq -r '._embedded.notices[] | [.forename,.date_of_birth,.entity_id,.nationalities[0],.name,._links.self.href,._links.images.href] | @csv' red-notices.json | awk -F, '{$(NF+1)=++i FS "red";}1' OFS=, >> red-notices.csv

echo -e "\n$resultPerPage red notices downloaded and converted to csv file --> red-notices.csv\n"
