# https://unix.stackexchange.com/a/471113
# %s/^[ ]\+/\t/g

#docker-compose-yaml-file := ./docker-compose_v3_ubuntu_mysql_latest.yaml
docker-compose-yaml-file := ./docker-compose_v3_ubuntu_mysql_local.yaml

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
	#docker compose -f $(docker-compose-yaml-file) build
	# compose version fails so using below as workaround
	for dir in `find . -name ubuntu`; do cd $$dir; ./build.sh; cd ~/code/zabbix-docker; done
	./retag-latest-to-local.sh

