# Architecture

## 服务
- [ ] [架构演变](/docs/服务/架构演变.md)
- [x] [三高](/docs/服务/服务的“三高”标准.md)
- [ ] 数据库篇
- [x] [缓存篇](/docs/服务/缓存.md)
- [ ] 消息队列篇
- 优化篇
    - [x] [池化技术](/docs/服务/优化/池化技术.md)


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
- [x] [一致性哈希算法](/docs/分布式协议和算法/一致性哈希算法.md)


### 分布式事务
- [x] [2PC](/docs/分布式事务/2PC.md)
- [ ] 3PC
- [ ] TCC
- [ ] 本地消息表
- [ ] MQ 事务消息
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


## RPC
- [intro](/docs/RPC/RPC.md)
- Dubbo
    - [intro](/docs/RPC/Dubbo/Dubbo.md)
    - [x] [Dubbo 的负载均衡策略](/docs/RPC/Dubbo/Dubbo负载均衡.md)


## Elasticsearch

- [ ] [倒排索引](/docs/Elasticsearch/倒排索引.md)
- [面试题](/docs/Elasticsearch/面试题.md)