
REMOVE=docker-compose rm --force
UP=docker-compose up -d

all:
	make clean
	make up

clean:
	$(REMOVE) data
	$(REMOVE) solr
	$(REMOVE) redis
	$(REMOVE) memcached
	$(REMOVE) mysql
	$(REMOVE) teamcityserver

up:
	$(UP) data
	$(UP) solr
	$(UP) redis
	$(UP) redis
	$(UP) memcached
	$(UP) mysql
	$(UP) teamcityserver

