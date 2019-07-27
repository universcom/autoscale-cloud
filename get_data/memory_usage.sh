#!/bin/bash

export OS_PROJECT_DOMAIN_NAME=Default
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=admin
export OS_USERNAME=admin
export OS_PASSWORD=hamed
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export GNOCCHI_ENDPOINT=http://controller:8041
export OS_AUTH_TYPE=password

Instance_id=`nova list | tail -n 2 | head -n 1 | cut -d "|" -f 2 |sed 's/ //g'`
measures_id=`gnocchi resource show $Instance_id -c metrics -f yaml| grep -w "memory.usage" | cut -d ':' -f 2`
value=`gnocchi measures show $measures_id --granularity 1 | tail -n 2 | head -n 1 | cut -d "|" -f 4 | sed 's/ //g'`
if [[ $? -eq "0" ]]
then
        echo `date +"%d-%m-%y-%T"` " | " $value >> memory_usage.txt
fi
