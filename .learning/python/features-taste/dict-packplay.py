
#: param unpack
(lambda xxx, a: print((a,xxx)))(** { 'a': 1, 'xxx': True }) #> (1, True)
(lambda xxx, a: print((a,xxx)))(a = 1, xxx = True) #> (1, True)

#: special use: as namespace
import types
opts = types.SimpleNamespace(** { 'a': 1, 'xxx': True })
print(opts) #> namespace(a=1, xxx=True)
type(opts) #> types.SimpleNamespace
print((opts.a, opts.xxx)) #> (1, True)

#: another way: as namespace
ns_dic = lambda dic: type ('dict_as_namespace', (), dic) ()
opts = ns_dic({ 'a': 1, 'xxx': True })
print(opts) #> <__main__.dict_as_namespace object at 0x000002631F3AD940>
type(opts) #> __main__.dict_as_namespace
print((opts.a, opts.xxx)) #> (1, True)

#: also support ns it self
dic_demo = { 'a': lambda ns_self: 1, 'b': lambda ns_self: ns_self.a() + 1, 'fnc': lambda ns, x, y: x * y + ns.a() + ns.b() }
opts1 = ns_dic(dic_demo)
opts2 = ns_dic(dict(dic_demo))
opts3 = ns_dic(dict(** dic_demo))
opts1.fnc(60, 2) #> 123
opts2.fnc(60, 2) #> 123
opts3.fnc(60, 2) #> 123
#:	123 = 60 * 2 + 1 + (1 + 1)
#:	and because of type() make entrys in dic became class-property,
#:	 and fn class-property is class-method,
#:	 and first param for method is obj itself (that's the thing usually named 'self' in py, like the `this` in js.),
#:	 so, in opts1.fnc(60, 2) here, opts1 is the real 1st param we inputed in that call.
#:	but, for xxx = types.SimpleNamespace(** dic), it just gives dic value to xxx.__dict__ property,
#:	 so it is just a dict but just can query entrys by the dot syntax,
#:	 so, this one cannot using the object-self at the function's 1st param.

#: because opts3 is able to use, so we can play like this (with some tmpl codes): 
yd = ns_dic(dict(
	a = lambda yard: 
		1, 
	b = lambda yard: 
		yard.a() + 1, 
	fnc = lambda yard: 
		lambda x, y: x * y + yard.a() + yard.b(), 
	_ = ...))
#: then access entrys in this ns/yard ...
print((yd.a(), yd.b(), yd.fnc()(60, 2))) #> (1, 2, 123)

#:	函数 `type` 可以用来创建类，从而支持基于字典 (dict) 来建立具有相应属性 (attribute) 的实例。此处有语法糖：
#:	-	类的属性 (attribute) 其实为字典：
#:		-	有 `module_name.x = 1` 即 `module_name.__dict__["x"] = 1` - https://docs.python.org/3/reference/datamodel.html?highlight=dictionary#modules
#:		-	有 `ClassName.x` 即 `ClassName.__dict__["x"]` - https://docs.python.org/3/reference/datamodel.html?highlight=dictionary#custom-classes
#:	-	而依此类所建实例 (instance) 的方法 (method) 亦实为类属性中的函数、其语法糖与 R 语言基本对象系统中的管道 (pipe) 类似：
#:		-	有 `instance_name.f(a)` 即 `ClassName.f(instance_name, a)` - https://docs.python.org/3/reference/datamodel.html#instance-methods
#:		-	如 `instance_name |> f(a)` 即为 `instance_name |> f.class_name(a)` 即 `f.class_name(instance_name, a)` 在于 R 中（此 `instance_name` 对象于其 `class` 属性中需有 `'class_name'` 这个标记）


#: also for tuple/list but use single `*`
(lambda a, b: a + b) (*(1, 2)) #> 3
(lambda a, b: a + b) (*[1, 2]) #> 3





