#!/bin/bash

for image_id in `docker images | grep ubuntu-latest | awk '{print $3}'`; do
  image_name=`docker images | grep $image_id | awk '{print $1}'`
  docker tag $image_name:ubuntu-latest $image_name:ubuntu-local
done

docker images | grep ubuntu
