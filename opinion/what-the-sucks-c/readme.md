
[lnk]: https://www.zhihu.com/question/24466000/answer/2832939897

using at: 

- [C 语言指针怎么理解？ - 果实下落 | 知乎][lnk]

-----

这玩意儿 (C Language) 难以理解的原因， (一方面) 在于符号含义的设计：

- ***星号在左边和右边含义不同***

~~~ c
&j ; // means: j.point, and type(j.point) is Point<TypeOfJ>
*i ; // means: i.value, and type(i) is Point<TypeOfValueOfI>

// but ...

int *i = &j ;

// is not: i.value = j.point
// it is: i = j.point
// int* means point<int>
// so `int* i` is better than `int *i`

// so one terrible thing is
// *i have different mean
// when it at the left of = with at the right.

// at ='s left, * means type Point<T>
// at ='s right, * means getValue() method for Point<T> type things


// ----------
// other terrible things: 

int (* a)[3] ; // type: Point<Array<int>>
int* b[3] ; // type: Array<Point<int>>

// ... what an awesome ...
// ... about this language's design ...
// :P
~~~

我知道，它实际上和 Java/C#/Scala/... 的类型系统里的泛型，完全是两码事。

但，我也没说我是在用 Java/C#/Scala/... 的类型系统来表示呀！🙃

上文只是要体现它的语言设计问题罢了：

- 星号在等号左右不一致 (而这貌似只是为了能让 `*i` 在左边被赋值了接着以同样的形式 `*i` 在右边用？还是说有什么别的历史原因 ... awesome ... ) 。
- 表示某种复合的关系 (这里需要强调的重点其实是类型之间的关系而非类型) 时，它根本不明确。

或者说，在做的事情实际就是 ***祛魅*** ——这是有助于理解一个**现实事物**的重要的工作。因为，如果没有这个工作，你甚至无法分清哪部分是 *魅* 的现实存在、而哪部分是另外部分的 (可能是你真正需要关注的部分) 现实存在。

而好的设计，会自己主动地祛魅。其余就是坏的设计。

——也因而，一个固定不变的设计的好坏会随着时代 (换句话说这也是 *现实事物* 层的上下文) 的变化而有所改变。
