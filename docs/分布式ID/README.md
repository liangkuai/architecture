# 分布式 ID

唯一 ID 常见的方式是 UUID 和数据库的自增主键，但是
1. UUID 太长、无规则、无序，不适合在 InnoDB 中作主键；
2. 在分表之后，使用数据库的自增主键会出现冲突；
3. 很多业务系统都需要一个唯一 ID 做标识，如：订单；

所以需要单独的方式生成全局唯一 ID，也叫做分布式 ID。

包括两种分布式 ID，
- 递增
    - 数据库
    - 号段模式
    - Redis
- 非递增
    - UUID
    - Snowflake 算法

---
### 1. UUID
UUID（Universally Unique Identifier）包含 32 个 16 进制数字，以连字号分为 5 段，形式为 `8-4-4-4-12` 的 32 个字符，到目前为止业界一共有 5 种方式生成 UUID。

#### 优点
- 性能高，本地生成，没有网络消耗。

#### 缺点
- 太长，不易存储；
- 不适合做数据库主键。


---
### 2. 数据库自增 ID
```sql
CREATE DATABASE `GID`;

CREATE TABLE GID.SEQ_ID (
	id bigint(20) unsigned NOT NULL auto_increment, 
	stub varchar(10) NOT NULL default '',
	PRIMARY KEY (id),
	UNIQUE KEY stub (stub)
);
```
`stub` 字段没什么含义，只是为了插入数据，只有能插入数据才能产生自增 ID。

#### 优点
- 简单，利用现有数据库实现即可；
- ID 单调自增，可以实现一些对 ID 有特殊要求的业务。

#### 缺点
- 可用性低，强依赖数据库，如果数据库实例下线，那么将影响所有的业务系统（虽然主从复制模式可以提高可用性，但是主备切换可能会产生数据不一致的情况，就可能出现重复 ID）；
- 性能瓶颈，受限于单个实例的读写性能。


---
### 3. 数据库多主模式
如果使用多主模式，也就是多个 MySQL 实例都可以生成自增 ID，就能提高效率和可用性。不过需要进行一些配置，不然会产生相同的 ID。

配置每个实例的
- 自增 ID 起始值：`auto_increment_offset`
- 自增步长：`auto_increment_increment`

如果用两台实例，可以这么配置
```sql
-- 实例1
set @@auto_increment_offset = 1;
set @@auto_increment_increment = 2;

-- 实例2
set @@auto_increment_offset = 2;
set @@auto_increment_increment = 2;
```
经过上述配置后，两个实例生成的 ID 序列分别是：1、3、5、7... / 2、4、6、8...

这种分布式 ID 生成方式需要单独写一个小服务，比如：`DistributIdService`，提供一个接口给业务应用获取分布式 ID。业务应用通过 RPC 调用 `DistributIdService` 服务，由 `DistributIdService` 随机从多个实例中获取 ID。

虽然多实例能够提高性能和可用性，但是这种方式扩展性不太好，增加实例需要修改原有实例的自增步长，控制新实例的起始步长，控制不好就会出现重复 ID。


---
### 4. 号段模式
上述使用数据库生成分布式 ID 的方式中，业务系统每次需要一个 ID 都要请求一次数据库，对数据库压力大。

号段模式可以理解为，分布式 ID 服务 `DistributIdService` 每次获取一批连续的 ID，缓存在本地，用完之后再去数据库取新的一批，既提高业务应用获取 ID 的效率，也大大减轻了数据库的压力。

数据库设计为，
```sql
CREATE DATABASE `GID`;

CREATE TABLE GID.SEQ_ID (
	biz_tag varchar(128) NOT NULL,
    max_id bigint(20) unsigned NOT NULL default 1,
    step int(11) unsigned  NOT NULL,
	desc varchar(256) default NULL,
	PRIMARY KEY (biz_tag)
);
```
- `biz_tag` ：用来区分业务
- `max_id` ：表示该 `biz_tag` 目前被分配的 ID 号段的最大值
- `step` ：每次分配的号段长度

原来每次获取 ID 都需要写数据库，现在只需要把 step 设置的足够大，比如 1000，那么只有当这 1000 个 ID 用完之后才回去重新读写一次数据库，读写频率从 1 降到了 1/step。

> 更新并获取号段可以用如下 SQL：
> ```sql
> Begin
> UPDATE table SET max_id=max_id+step WHERE biz_tag=xxx
> SELECT biz_tag, max_id, step FROM table WHERE biz_tag=xxx
> Commit
> ```

为了提高可用性还可以对数据库使用多主模式部署。

#### 应用
- [tinyid - didi - GitHub](https://github.com/didi/tinyid)


---
### 5. Snowflake 算法
Snowflake（雪花）算法的作用是让负责生成分布式 ID 的每台机器在每毫秒内生成不一样的 ID。

#### 原理
Snowflake 生成的分布式 ID 是一个 long 型数字，占 8 个字节（64 bit），如下图，

![Snowflake](/assets/images/分布式ID/snowflake.png)

把 64 bit 划分为多个段，
- 第一个 bit 是标识部分，由于 long 的最高位是符号位，正数是 0，负数是 1，一般生成的 ID 为正数，所以固定为 0。
- 41 bit 是产生 ID 的毫秒级时间戳，可以使用 69 年，(1L << 41) / (1000L * 60 * 60 * 24 * 365) = 69年。
- 10 bit 是机器 id，可以部署 1024 个节点。
- 12 bit 是自增序号，支持同一毫秒内同一个节点可以生成 4096 个 ID。

理论上整个算法一秒能够产生 409.6w 个 ID。

#### 优点
- 毫秒数在高位，自增序列在低位，整个 ID 都是趋势递增的。
- 不依赖数据库等第三方系统，以服务的方式部署，性能和稳定性高。
- 可以根据自身业务特性分配 bit 位，非常灵活。

#### 缺点
- 强依赖机器时钟，如果机器上时钟回拨，会导致发号重复或者服务处于不可用状态。

#### 应用
- MongoDB ObjectId，生成方式类似于 Snowflake 算法。

#### 框架
- [Leaf - Meituan - GitHub](https://github.com/Meituan-Dianping/Leaf)
- [uid-generator - baidu - GitHub](https://github.com/baidu/uid-generator)


---
### 6. Redis
利用 Reids 提供的原子性自增命令 `incr`。



### 参考
- [分布式ID生成方案总结 - Snailclimb - GitHub](https://github.com/Snailclimb/JavaGuide/blob/master/docs/system-design/micro-service/%E5%88%86%E5%B8%83%E5%BC%8Fid%E7%94%9F%E6%88%90%E6%96%B9%E6%A1%88%E6%80%BB%E7%BB%93.md) / [分布式ID生成方案总结 - Snailclimb - Gitee](https://gitee.com/SnailClimb/JavaGuide/blob/master/docs/system-design/micro-service/%E5%88%86%E5%B8%83%E5%BC%8Fid%E7%94%9F%E6%88%90%E6%96%B9%E6%A1%88%E6%80%BB%E7%BB%93.md)
- [Leaf——美团点评分布式ID生成系统 - 美团技术团队](https://tech.meituan.com/2017/04/21/mt-leaf.html)
- [Leaf：美团分布式ID生成服务开源 - 美团技术团队](https://tech.meituan.com/2019/03/07/open-source-project-leaf.html)