#!/bin/bash

for file in `find Dockerfiles -name Dockerfile`; do
    echo "$file"
    head -n 5 "$file"
#    gsed 's/\(ARG\ BUILD_BASE_IMAGE=\)/\1zabbix\//' "$file" | head -n 5
    gsed -i 's/\(ARG\ BUILD_BASE_IMAGE=\)/\1zabbix\//' "$file"
    head -n 5 "$file"
    echo
#    exit
done

