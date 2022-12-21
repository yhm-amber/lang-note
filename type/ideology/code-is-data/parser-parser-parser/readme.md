## cases

一套代码，依据解释器的不同而具备不同的意义。

比如同一段 `lisp` 代码，将其作为这个解释器的输入时会被解释为有序列表，作为另一个解释器输入时又可以是无序的键值对。这就造就了一种灵活（或许还优雅）的操作：指定不同的解释应用于同一数据，取得需要的几种特性。

看起来大概就是这种形式：

~~~ nu
((a 1) (b 2) (c 3) (d 4)) | parse list kv ## like: [a:1, b:2, c:3, d:4]
((a 1) (b 2) (c 3) (d 4)) | parse list tuple ## like: [(a,1), (b,2), (c,3), (d,4)]
((m ((a 1) (b 2))) (n ((c 3) (d 4)))) | parse map map kv ## like: {m:{a:1, b:2}, n:{c:3, d:4}}
~~~

上面左边是把 `如何理解数据的标记` 记录在了数据以外，右边是譬如 `Python` 之类的流行语言把 `如何理解数据的标记` 同数据本身融合在一起记录。

两种方法各有所长。

左边的方案，不论编写还是阅读都没有右边那么显眼。但其实如果能妥当格式化外加给编辑器附加特定功能，这应该也不算大问题；而这样带来的好处有：

- 灵活：你的代码就是有结构的数据，因此你可以生成数据然后用特定的解释器（可以就是当前语言本身）来解释执行它。那么，基本上，你可以做任何事了。
- 元编程：这其实是上一点的更进一步，被生成的数据会被视为当前上下文的代码来编译或解释（如果要编译的话就需要语言能够先解释元编程的部分——即 `宏展开时 (Macro Expansion Time)` ——再整个地编译所有生成或手写的代码）

更何况，它可以不用看起来或者写起来只能是这样。

右边的方案，对编写和阅读的有利是显而易见的（这可能也是为什么它会流行），不过灵活度——特别是这些语言的实现的灵活或优雅的程度——就不如前者了，如果没有哪一面向用户的实现层支持左边的形式的话。

## unite

但，上面左侧的方案，仍然可以通过 `语法糖` 之类的手段，让它外形看起来与右边一致。如此说来，它倒也可以作为右侧那种观感的一个优雅地实现其自身的方案（的底层部分）来存在了。

上面只是形式的一种，譬如这样的写法通过一个另外的解释器就可以实现为上面那样：

~~~ lisp
('list ('kv a 1) ('kv b 2) ) ;; then we just need a parser just trans it be: `((a 1) (b 2) (c 3) (d 4)) | parse list kv`
~~~

然后，这将成为进一步实现语法糖效果的基石。（即，再实现一个解释器，而它只需要做到把特定括号转换为以特定 `symbol` 开头的 S 表达式就好。）