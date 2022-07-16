# https://unix.stackexchange.com/a/471113
# %s/^[ ]\+/\t/g

docker-compose-yaml-file := ./docker-compose_v3_ubuntu_mysql_latest.yaml

start:
	docker compose -f $(docker-compose-yaml-file) up -d 
	docker compose -f $(docker-compose-yaml-file) logs -f

stop:
	docker compose -f $(docker-compose-yaml-file) stop

destroy:
	docker compose -f $(docker-compose-yaml-file) down
	docker system prune -f

restart:
	docker compose -f $(docker-compose-yaml-file) restart

logs:
	docker compose -f $(docker-compose-yaml-file) logs -f

console:
	docker exec -it zabbix-docker-zabbix-web-nginx-mysql-1 bash

build:
	#docker-compose build

