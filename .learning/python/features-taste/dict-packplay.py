
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
#: 123 = 60 * 2 + 1 + (1 + 1)
#: and because of type() make entrys in dic became class-property,
#:  and fn class-property is class-method,
#:  and first param for method is obj itself (usually named self like `this` in js),
#:  so, in opts1.fnc(60, 2) here, opts1 is the real 1st param we inputed in that call.
#: but, for xxx = types.SimpleNamespace(** dic), it just gives dic value to xxx.__dict__ property,
#:  so, this one cannot using the object-self at the function's 1st param.

#: because opts3 is able to use, so we can play like this: 
yd = ns_dic(dict(
	a = lambda yard: 
		1, 
	b = lambda yard: 
		yard.a() + 1, 
	fnc = lambda yard: 
		lambda x, y: x * y + yard.a() + yard.b(), 
	_ = ...))
print((yd.a(), yd.b(), yd.fnc()(60, 2))) #> (1, 2, 123)


