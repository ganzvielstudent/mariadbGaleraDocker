#!/bin/bash
#This file creates the starting node. The database is located in mysql, the config file in mysql.conf.d
#The code in the last line generates the current IP of the server

sudo docker run \
--name mariadb-0 \
-d \
-v mysql.conf.d:/etc/mysql/conf.d \
-v mysql:/var/lib/mysql \
-e MYSQL_INITDB_SKIP_TZINFO=yes \
-e MYSQL_ROOT_PASSWORD=my-secret-pw \
-p 3306:3306 \
-p 4567:4567/udp \
-p 4567-4568:4567-4568 \
-p 4444:4444 \
mariadb:latest \
--wsrep-new-cluster \
--wsrep_node_address=$(ip -4 addr ls eth0 | awk '/inet / {print $2}' | cut -d"/" -f1)
