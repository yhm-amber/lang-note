
~~~ factor
lang note . 🥱🚰
~~~

- [实例](./instances)
- [使用](./usages)

----

behavior: 

- `org-mode` 用于目录树简短说明
- `markdown` 用于描述观点/内容的文档

interpret:

- language 一定是运作于一个基础——称之为 os ——之上的。
- language 自身有时也可视为 os ——从而某些对特定 language 提供了 api 的工具也算是以这些 language (以及它们的运行前提) 为 os 运行的 language 。
- language 就是具备翻译——又叫 trans 或转换——功能的工具 (以及对应的标准与设计) 。

- trans 包括：
  
  - 一堆符号到另一堆符号的映射的转换
  - 一堆符号到机器 (或者说自然力) 范畴的行为 (behavior) 的转换
  
  一个 CPU 也可以视为是对一套指令集 (语言的设计与标准集合) 的实现 (implement) ——是该一指令集标准 (language) 的解释器 (parser) ——而标准也就是接口 (interface) 。
  
- implement 即实现即是语言的在场 (或者说就是通常说的"这个语言本身") ——严格意义上的实现是包括一个实现所基于的所有实现的：譬如 erlang 的实现一定包括了能充当解释器的 VM 自己能运行这个 VM 的一切基础——但我们只说关键 (有变化有不同) 的部分因而着重关注的只有那个 VM 而其余一切皆被视为平台 (platform) 了就。
- platform 一定是一个具备 language 应具备之功能的存在物 (在场/实现) 。
- platform 即是不被着重强调从而成为了背景板了的某个 language 层。
- platform 自然也有它相对于它的特别以外与同层其它实现共同的部分——诸多实例存在的共性与区别支撑起了 platform 们分层的现世结构存在 (implement) 。
- language 就其本质而言即是 interface 而一个它的 parser 即是一个它的现世存在 (implement) (在场) 方案 (scheme) 。
- language 的一个 parser 可以由本 language 经过 trans 而成 (这种情况就叫自举了) 也可以由别的随意任何 language 转换 (编译或者解释) 而成。
- parser 可以由什么 language trans 而成只与该 language 的能力有关 (其中包括了这个 parser 要成功运作的所有 platform 层的能力因为这些 platform 层是具体什么样是被 trans 为此 parser 的 language 有所限定的) 。
- parser 有时只能基于 trans 成它的那个 language 运作 (即只能以该 language 为其 platform (有时还会增加少量的同一层别的种类的 platform 的支持) 来运作) 这与该 language 的设计本身有关——而不代表 trans 成它的 language 限制了这个 parser 的设计。


