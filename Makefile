# https://unix.stackexchange.com/a/471113
# %s/^[ ]\+/\t/g

#docker-compose-yaml-file := ./docker-compose_v3_ubuntu_mysql_latest.yaml
docker-compose-yaml-file := ./docker-compose_v3_ubuntu_mysql_local.yaml

zabbix-version := 6.2.2

start:
	docker compose -f $(docker-compose-yaml-file) --profile all up -d 

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
	for dir in `find . -name ubuntu | grep -v pgsql | grep -v agent2 | grep base`; do cd $$dir; echo $$dir;./build.sh; cd ../../../; done
	./retag-latest-to-local.sh
	docker tag bnowakow/zabbix-build-base:ubuntu-local bnowakow/zabbix-build-base:ubuntu-$(zabbix-version)
	docker push bnowakow/zabbix-build-base:ubuntu-$(zabbix-version)
	for dir in `find . -name ubuntu | grep -v pgsql | grep -v agent2 | grep -v base | grep build`; do cd $$dir; echo $$dir;./build.sh; cd ../../../; done
	./retag-latest-to-local.sh
	docker tag bnowakow/zabbix-build-sqlite3:ubuntu-local bnowakow/zabbix-build-sqlite3:ubuntu-$(zabbix-version)
	docker tag bnowakow/zabbix-build-mysql:ubuntu-local bnowakow/zabbix-build-mysql:ubuntu-$(zabbix-version)
	docker push bnowakow/zabbix-build-sqlite3:ubuntu-$(zabbix-version)
	docker push bnowakow/zabbix-build-mysql:ubuntu-$(zabbix-version)
	for dir in `find . -name ubuntu | grep -v pgsql | grep -v agent2 | grep -v build | grep -v base`; do cd $$dir; echo $$dir;./build.sh; cd ../../../; done
	./retag-latest-to-local.sh
	for image in `docker images | grep ubuntu-local | grep bnowakow | awk '{print $1}'`; do docker push $$image:ubuntu-local; done

delete-images:
	docker images | grep zabbix | awk '{print $3}' | xargs docker rmi -f
