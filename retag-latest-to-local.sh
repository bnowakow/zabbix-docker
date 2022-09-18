#!/bin/bash

for image_id in `docker images | grep ubuntu-latest | grep '^zabbix' | awk '{print $3}'`; do
    image_name=`docker images | grep ubuntu-latest | grep $image_id | awk '{print $1}'`
    echo image_name=$image_name image_id=$image_id
    docker tag $image_name:ubuntu-latest bnowakow/$image_name:ubuntu-local
done

docker images | grep ubuntu-l
 
