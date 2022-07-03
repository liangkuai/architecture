# Docker 部署

> 仅用于本地测试


### 1. 拉取镜像

#### 1.1 可挂载文件/目录

- `/data`
- `/datalog`
- `/logs`
- `/conf/zoo.cfg`


### 2. 创建容器

#### 2.1 准备配置文件

参考基础配置文件：[zoo_sample.cfg](/assets/zk/zoo_sample.cfg)

#### 2.2 创建本地文件/目录

- `/var/lib/zookeeper/zk1/data` ：`/data`
- `/var/lib/zookeeper/zk1/datalog` ：`/datalog`
- `/var/lib/zookeeper/zk1/logs` ：`/logs`
- `/var/lib/zookeeper/zk1/zoo.cfg` ：`/conf/zoo.cfg`

#### 2.3 创建命令

```bash
#!/bin/bash

docker container run \
    --name zk1 \
    -p 2181:2181 \
    -v /var/lib/zookeeper/zk1/data:/data \
    -v /var/lib/zookeeper/zk1/datalog:/datalog \
    -v /var/lib/zookeeper/zk1/logs:/logs \
    -v /var/lib/zookeeper/zk1/zoo.cfg:/conf/zoo.cfg \
    -v /tmp:/tmp \
    -d zookeeper:3.6.2
```


### 3. 集群模式

手动配置多个 zk 容器，或者用 `docker-compose`。


### 4. 参考

- [zookeeper - dockerhub](https://hub.docker.com/_/zookeeper)

