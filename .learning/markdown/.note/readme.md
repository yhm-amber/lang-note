

### 文本

#### 块

block

##### 代码段

~~~~~ markdown
words `code` words
~~~~~

##### 代码块

~~~~~ markdown
words words: 

~~~ sh
echo yey
echo yey
~~~

or: 

~~~~ sh
seq 7 | xargs -i -- echo 'yey {} ~'
echo yey
~~~~

words words ...
~~~~~

##### 引用

~~~~~ markdown
> words `code` words
> 

引用块里的渲染和正文规律一样
只是会稍微灰色一点或者别的效果
来体现这是引用的部分
~~~~~

##### 贴士

~~~~~ markdown
> **Note**
> 
> words `code` words
> 

还有 `Warning` 和 `Error` 也可得到渲染

这个写法只适用于部分渲染引擎 (github) 。
~~~~~

~~~~~ markdown
这是 yanknote 的特有扩展写法：

:::: tip 可选的标题
冒号个数可以是三个以上任意个，
可以嵌套。

种类还可以是：

- 警告 `warning`
- 危险 `danger`


以及更多的：

- 详情 `details`
- 标签组 `group` 和标签 `group-item` 嵌套其中
- 分列 `row` 和列 `col` 嵌套其中

更多见 [https://yank-note.vercel.app] 的特色功能说明。
::::
~~~~~


### 结构

#### 段落

paragraph

##### 换行

~~~~~ markdown
ala ala ho ?
 holo holo ai !
 yoooooooooo ....

上面的代码是三行？
但渲染后你不会看到任何换行。
会和下面的一样：

ala ala ho ? holo holo ai ! yoooooooooo ....

或者这样也是完全一样：

ala ala
 ho ? holo
 holo ai
 ! yoooo
oooooo ....

希望段落内的换行符？
代码上的连续的两个空格一个回车
渲染后就会变成一个换行符，像这样：

heiheihei,
 heiheihei!  
yoyoyo!

在渲染后， `yoyoyo!` 会另起一行。  
**但这不是新段落**。

引用同理：

> heiheihei,
>  heiheihei!  
> yoyoyo!
> 

~~~~~

##### 新段落

~~~~~ markdown
这是一个段落

代码上隔一个空行
就表示又是一个段落

仅此而已。🙃  
段落内换行一般很少使用，
都是新起一段。

但代码换行而渲染效果不换行
这个其实很有用，毕竟
 markdown 的理念就是
纯文本代码也能最好像
渲染后的内容一样来阅读。
~~~~~

#### 列表

list

##### 无序列表

~~~~~ markdown
ala ala hobb: 

- ala ala
- hob hop hobb
- ala yooooooo ...
- yeye hei!
- hmm ...

more line per: 

- ala ala
  same line ala yoo
  
  new paragraph
   and code: 
  
  ~~~ sh
  echo yey
  echo hooo
  ~~~
  
- some others ...
  
  > foo bar baz ...
  > 
  

~~~~~

##### 有序列表


~~~~~ markdown
ala ala hobb: 

1. ala ala
2. hob hop hobb
3. ala yooooooo ...
4. yeye hei!
5. hmm ...

more line per: 

1.  ala ala
    same line ala yoo
    
    new paragraph
     and code: 
    
    ~~~ sh
    echo yey
    echo hooo
    ~~~
    
2.  some others ...
    
    > foo bar baz ...
    > 
    

~~~~~

