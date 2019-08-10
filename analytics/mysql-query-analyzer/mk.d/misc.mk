SHELL := /bin/sh

.PHONY: mysql/logs
mysql/logs:
	@docker-compose \
		-f ./docker-compose.databases.yml \
		-f ./docker-compose.beats.yml \
		-f ./docker-compose.search_engine.yml \
		-f ./docker-compose.dashboards.yml \
		exec filebeat cat /var/log/mysql/mysql-slow.log

.PHONY: db/seed
db/seed:
	@docker run --rm \
		--network workbench \
		emirozer/fake2db \
			--rows 250 \
			--db mysql \
			--name test \
			--host mysql \
			--username root \
			--password root

.PHONY: db/query
db/query:
	@docker run --rm \
		--network workbench \
		--entrypoint /usr/bin/mysql \
		mysql:5.6 \
			-h mysql \
			-P 3306 \
			-u root \
			-proot \
			--execute 'SELECT * FROM test.company'

.PHONY: filebeat/setup
filebeat/setup:
	@docker-compose \
		-f ./docker-compose.databases.yml \
		-f ./docker-compose.beats.yml \
		-f ./docker-compose.search_engine.yml \
		-f ./docker-compose.dashboards.yml \
		exec filebeat filebeat setup --strict.perms=false
