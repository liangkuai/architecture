# 3PC

Three-Phase Commit，三阶段提交。



### 和 2PC 的区别
- 引入了参与者超时机制，解决同步阻塞问题，避免资源被永久锁定；
- 增加了预提交阶段使得故障恢复之后协调者的决策复杂度降低，但整体的交互过程更长了，性能有所下降，并且还是会存在数据不一致问题。


### 原理


#### 第一阶段：询问


#### 第二阶段：准备


#### 第三阶段：提交








### 参考
- [1.4w字，25 张图让你彻底掌握分布式事务原理 - allentofight - GitBook](https://codesea.gitbook.io/allentofight/xi-tong-she-ji/1.4w-zi-25-zhang-tu-rang-ni-che-di-zhang-wo-fen-bu-shi-shi-wu-yuan-li)
- [分布式事务 - 三太子敖丙 - 微信公众号](https://mp.weixin.qq.com/s/XknegP66mnYboiBx556Kzw)