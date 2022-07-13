#!/bin/bash

#docker-compose -f ./docker-compose_v3_ubuntu_mysql_local.yaml up -d

#docker compose -f ./docker-compose_v3_ubuntu_mysql_local.yaml up -d
docker compose -f ./docker-compose_v3_ubuntu_mysql_latest.yaml up -d
docker compose -f ./docker-compose_v3_ubuntu_mysql_latest.yaml logs -f

