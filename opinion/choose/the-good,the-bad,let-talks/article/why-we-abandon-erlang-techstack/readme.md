ref: https://developer.aliyun.com/article/229322

----

# 为什么我们放弃了Erlang技术栈

`2017-10-31` `rippletek.com`

至2013年小博无线云端系统上线以来，我们一直是Erlang的重度使用者。尽管小博无线技术团队不乏拥有10年以上经验的精英级Erlang程序员，然而，从2016年开始，我们已不再使用Erlang开发新业务，而我们放弃Erlang技术栈的原因可被简要概括为下面这句话：

**让开发和运维更简单**

总的来说，Erlang技术栈的优点在云计算环境中要么难以体现，要么容易寻找到成熟的替代方案，但弱点却既顽强又难以绕开。以下逐一展开说明。

## 优点: 易用的高并发轻量级进程

这一度是Erlang独有的优势，但在今天，基于nginx+lua的openresty框架和golang都能提供，并且后两者还拥有更好的社区生态。

## 优点: 公平可靠的软实时调度

虽然lua, golang, nodejs在语言层面都内置了高并发机制，然而，不论是lua中需手动调用yield/resume的coroutine，或是golang中在系统调用时插入yield的goroutine，还是nodejs中依靠异步io回调实现的单线程多并发，都存在面对cpu密集型计算任务时调度不均的问题，因为它们都没有实现cpu使用统计与抢占式调度器。

Erlang VM对每个进程[1]的cpu占用进行了统计并实现了抢占式调度，即使某个进程不停计算，其他进程也不会被饿死。

这听上去很好，但在互联网业务系统中，却并没有多少实用价值。如果发现有部分业务计算逻辑需要消耗大量cpu以致影响了系统的整体响应或吞吐，说明应当将这部分计算功能抽离到一个单独的运行环境并给它分配更多的资源，而不是依赖VM的抢占调度！

## 优点: 位置透明性

Erlang内建的rpc机制可以让任意两个进程相互之间无需知晓对方的所在的结点，仅通过pid就能透明的向对方发送消息。

这一优点可以使用成熟的消息队列中间件获得，消息队列中间件能自然实现业务处理的前后端分离，并且前后端还可独立进行伸缩。

## 优点: 热更新

采用Erlang构建的系统可以在服务不中断，用户无感知的情况下部署变更。

使用“漂移上线”[2]可以获得同样的效果，并且对于采用任何技术栈构建的系统都是有效的。

## 弱点：全连通集群

Erlang集群采用的是全连通的组网方式，每加入一个新节点，都需要在当前集群中所有节点的/etc/hosts文件中加入这个新节点的hostname和ip，这样的设计使得伸缩和漂移都非常麻烦。

在云计算环境中，使用以负载均衡器为根，业务容器为叶结点的网络拓扑则要简单很多，可以很方便的实现秒级伸缩和漂移。

一种绕开的方案是自建DNS服务负责集群的域名解析，然而，这个方案又会带来诸如DNS服务的高可用性，新建记录的生效时间以及本地记录的缓存刷新等一系列问题。

## 弱点：部署之痛

Erlang设计的运行时是直接运行于宿主机上的，当第一次启动Erlang VM, 会随之启动一个epmd进程来负责集群结点之间的通信。这样的设计与容器化的部署方案格格不入，导致很难在一个宿主机上运行两个位于不同集群的Erlang容器。

## 弱点：数据库之伤

OTP中的mnesia是Erlang技术栈标配的高性能分布式内存数据库，支持对原生erlang term的透明存取，就单一的Erlang系统而言，mnesia的易用性和性能都是不错的。但是，在一个较复杂的云端系统中，它存在下面几个劣势：

- 定位过于专一，除了erlang外，几乎找不到其他编程语言可用的客户端，只能通过erlang代码代理访问，导致开发成本高
- 本身太小众，云厂商不会提供基于mnesia的SasS服务，只能自建，而且mnesia的数据分片功能对网络稳定性有很高的要求，导致运维成本高
- 未对数据进行压缩存储，当数据量上去后，会消耗大量内存，导致资源成本高

现在，我们已从mnesia全面切换到了redis。

---

- [1]这里的“进程”指的是由Erlang VM负责调度的轻量级进程，而不是由内核调度的OS原生进程
- [2]《[云计算十字真言及其在小博无线的实践](https://yq.aliyun.com/articles/62686)》一文详细介绍了“漂移上线”的设计思路以及一种具体的实现方法
