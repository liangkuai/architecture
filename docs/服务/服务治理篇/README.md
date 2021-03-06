# 服务治理

首先需要明确，不管是什么事物需要“治理”，那一定是该事物存在一定问题。比如环境治理。那么服务，或者说微服务为什么需要治理？

对于服务来说，如果它承担的业务职责简单，那其实治理的必要性不大，因为服务运行过程是相对透明的，即使出现问题也能较快发现、定位、回滚。

当服务承担的业务职责变多变大，那随着更多问题的到来，服务治理开始变得必要。服务治理也与技术架构本身息息相关。


### 单体服务
如果服务属于单体结构，服务治理的挑战更多是当单体架构由于承载的业务庞大，服务内部逻辑变得复杂，扩展性也变差。这时候往往不需要特别的服务治理手段，而是将单体服务拆分为微服务，即完成“微服务化”，将原有单体服务架构向微服务架构演进。


### 微服务
在微服务架构下，出现了新的服务问题，从而需要对微服务进行服务治理。

**1. 服务注册与发现**。单体服务拆分为微服务后，如果微服务之间存在调用依赖，就需要得到目标服务的服务地址，也就是微服务治理的“服务发现”。要完成服务发现，就需要将服务信息存储到某个载体，载体本身即是微服务治理的“服务注册中心”，而存储到载体的动作即是“服务注册”。

**2. 可观测性**。微服务由于较单体应用有了更多的部署载体，需要对众多服务间的调用关系、状态有清晰的掌控。可观测性就包括了
- 调用拓扑关系
- 监控（Metrics）
- 日志（Logging）
- 调用追踪（Trace）

**3. 流量管理**。由于微服务本身存在不同版本，在版本更迭过程中，需要对微服务间调用进行控制，以完成微服务版本的平滑更迭。这一过程中需要根据流量的特征（访问参数等）、百分比向不同版本服务分发，这也孵化出灰度发布、蓝绿发布、A/B测试等服务治理的细分主题。

**4. 安全**。不同微服务承载自身独有的业务职责，对于业务敏感的微服务，需要对其他服务的访问进行认证与鉴权，也就是安全问题。

**5. 控制**。对服务治理能力充分建设后，就需要有足够的控制能力，能实时进行服务治理策略向微服务分发。


### 实现
对于微服务治理，传统的做法都是需要引入微服务研发框架，配合控制平台完成如上服务治理能力的建设。比较常见的微服务研发框架包括 Spring Cloud、Dubbo 等。

讲到微服务框架本身，不妨多说一些。服务本身需要治理，其实传统微服务框架本身也存在一些问题，同样需要“治理”：
1. 微服务框架本身的引入需要业务服务有感知，需要修改代码或引入框架；
2. 框架本身的升级成本高，需要结合业务状态重启业务以更新框架；
3. 多语言支持不足。SpringCloud、Dubbo 都是 Java 语言主打框架，要想支持更多语言就变得十分困难。

这也就来到微服务架构新的时代 — Service Mesh。

服务网格是一个微服务基础设施，用于处理微服务通信、治理、控制、可观测、安全等问题，具备业务无侵入、多语言、热升级等诸多特性，是业界下一代微服务架构方向。



### 参考
- [一文详解微服务架构 - 古霜卡比](https://www.cnblogs.com/skabyy/p/11396571.html)
- [到底什么是服务治理? - 网易数帆的回答 - 知乎](https://www.zhihu.com/question/56125281/answer/1099439237)
