
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
dic_demo = { 'a': lambda ns_you: 1, 'b': lambda ns_you: ns_you.a() + 1, 'fnc': lambda ns, x, y: x * y + ns.a() + ns.b() }
opts1 = ns_dic(dic_demo)
opts2 = ns_dic(dict(dic_demo))
opts3 = ns_dic(dict(** dic_demo))
opts1.fnc(60, 2) #> 123
opts2.fnc(60, 2) #> 123
opts3.fnc(60, 2) #> 123
#: That's because of ...???


