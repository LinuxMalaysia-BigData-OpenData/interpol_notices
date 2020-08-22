#!/bin/bash

# https://github.com/US-CBP/GTAS/issues/1175
# apt install jq
# remove double quote  awk '{gsub(/"/,"")};1' yellow-notices.csv > output.csv

resultPerPage=8000

if [ -n "$1" ]; then
	resultPerPage=$1
else
	json=$(curl -s https://ws-public.interpol.int/notices/v1/yellow?resultPerPage=1)
	resultPerPage=$( jq -r '.total' <<< "${json}" )

fi

echo -e "\nDownloading $resultPerPage yellow notices\n "

curl -o yellow-notices.json https://ws-public.interpol.int/notices/v1/yellow?resultPerPage=$resultPerPage

echo "forename,date_of_birth,entity_id,nationalities,name,interpol_link,type" > yellow-notices.csv

jq -r '._embedded.notices[] | [.forename,.date_of_birth,.entity_id,.nationalities[0],.name,._links.self.href,._links.images.href] | @csv' yellow-notices.json | awk -F, '{$(NF+1)=++i FS "yellow";}1' OFS=, >> yellow-notices.csv

echo -e "\n$resultPerPage yellow notices downloaded and converted to csv file --> yellow-notices.csv\n"
