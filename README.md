# Architecture

## 服务
- [服务的“三高”标准](/docs/服务/服务的“三高”标准.md)
- [ ] [架构演变](/docs/服务/架构演变.md)
    - 单体架构
    - 微服务架构
- [ ] 数据库篇
- [x] [缓存篇](/docs/服务/缓存.md)
- [ ] 消息队列篇
- 服务治理篇
    - [intro](/docs/服务/服务治理篇/README.md)
    - [1. 服务注册与发现](/docs/服务/服务治理篇/1.服务注册与发现.md)
    - [2. 网关](/docs/服务/服务治理篇/2.网关.md)
    - [3. 限流](/docs/服务/服务治理篇/3.限流.md)
    - [4. 降级](/docs/服务/服务治理篇/4.降级.md)
    - [5. 熔断](/docs/服务/服务治理篇/5.熔断.md)
    - [6. 监控](/docs/服务/服务治理篇/6.监控.md)
    - [7. 链路追踪](/docs/服务/服务治理篇/7.链路追踪.md)
    - [8. 日志分析](/docs/服务/服务治理篇/8.日志分析.md)
- 优化篇
    - [x] [池化技术](/docs/服务/优化/池化技术.md)


## DDD

- [intro](/docs/DDD)


## 分布式

### 如何学习分布式技术？
#### 1. 理论
学习分布式架构设计核心且具有“实践指导性”的基础理论，这里面会涉及典型的分布式问题，以及如何认识分布式系统中相互矛盾的特性，帮助我们在实战中根据场景特点选择适合的分布式算法。

#### 2. 协议和算法
掌握它们的原理、特点、适用场景和常见误区。

#### 3. 实战
掌握分布式基础理论和分布式算法在工程实践中的应用，据场景特点选择适合的分布式算法。


### 分布式理论
- [x] [CAP 定理](/docs/分布式理论/CAP.md)
- [x] [BASE 理论](/docs/分布式理论/BASE.md)

### 分布式协议和算法
- [拜占庭将军问题](/docs/分布式协议和算法/拜占庭将军问题.md)
- [x] [一致性哈希算法](/docs/分布式协议和算法/一致性哈希算法.md)


### 分布式事务
- [intro](/docs/分布式事务/README.md)
- [x] [2PC](/docs/分布式事务/2PC.md)
- [ ] [3PC](/docs/分布式事务/3PC.md)
- [x] [TCC](/docs/分布式事务/TCC.md)
- [ ] [本地消息表](/docs/分布式事务/本地消息表.md)
- [ ] [基于消息中间件的最终一致性方案](/docs/分布式事务/基于消息中间件的最终一致性方案.md)
- [x] [最大努力通知方案](/docs/分布式事务/最大努力通知方案.md)
- [ ] Saga 事务模型


### 分布式 ID
- [intro](/docs/分布式ID/README.md)
- 递增
    - 数据库自增 ID
    - 数据库多主模式
    - 号段模式
    - Redis
- 非递增
    - UUID
    - Snowflake 算法


## ZooKeeper

- [intro](/docs/ZooKeeper/README.md)
- 数据模型
    - [ZNode](/docs/ZooKeeper/数据模型/ZNode.md)


## Elasticsearch

- [ ] [倒排索引](/docs/Elasticsearch/倒排索引.md)
- [面试题](/docs/Elasticsearch/面试题.md)