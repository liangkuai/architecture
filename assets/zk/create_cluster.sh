#!/bin/bash

docker container run \
    --name zk1 \
    -p 2181:2181 \
    -p 2182:2182 \
    -p 2183:2183 \
    -p 2881:2881 \
    -p 3881:3881 \
    -p 2882:2882 \
    -p 3882:3882 \
    -p 2883:2883 \
    -p 3883:3883 \
    -v /private/var/lib/zookeeper/zk1/data:/data \
    -v /private/var/lib/zookeeper/zk1/datalog:/datalog \
    -v /private/var/lib/zookeeper/zk1/logs:/logs \
    -v /private/var/lib/zookeeper/zk1/zoo.cfg:/conf/zoo.cfg \
    -d zookeeper

docker container run \
    --name zk2 \
    -p 2182:2182 \
    -v /private/var/lib/zookeeper/zk2/data:/data \
    -v /private/var/lib/zookeeper/zk2/datalog:/datalog \
    -v /private/var/lib/zookeeper/zk2/logs:/logs \
    -v /private/var/lib/zookeeper/zk2/zoo.cfg:/conf/zoo.cfg \
    -d zookeeper

docker container run \
    --name zk3 \
    -p 2183:2183 \
    -v /private/var/lib/zookeeper/zk3/data:/data \
    -v /private/var/lib/zookeeper/zk3/datalog:/datalog \
    -v /private/var/lib/zookeeper/zk3/logs:/logs \
    -v /private/var/lib/zookeeper/zk3/zoo.cfg:/conf/zoo.cfg \
    -d zookeeper