# interpol_notices
Example to crawl json from web using curl and covert it into csv using jq and sed. The query is limted to 160 result by json source.

Download jq from https://stedolan.github.io/jq/

base on disscussion https://github.com/US-CBP/GTAS/issues/1174

To docker

docker build -t my-interpol_notices .

docker run -it --rm --name my-running-interpol_notices my-interpol_notices

docker container exec -it containername /bin/bash
