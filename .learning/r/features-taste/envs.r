

list (a = 2) |> list2env (environment ())
assign ("a", 2, parent.frame())
assign ("a", 2)
a <- 2

#' Both these 3 lines have same effect
#' 

env = new.env()
f = \ (x) x^2

assign ("f", \ (x) x^3, env)
assign ("a", 5, env)

f(a) # [1] 4
do.call ("f", list(a)) # [1] 4

#' 上述 2 行是: 
#' 在环境 parent.frame()
#' 用该环境的 f
#' 传当前环境的 a
#' 

do.call ("f", list(a), envir = env) # [1] 8

#' 上述 1 行是: 
#' 在环境 env
#' 用该环境的 f
#' 传当前环境的 a
#' 

do.call (f, list(a), envir = env) # [1] 4

#' 上述 1 行是: 
#' 在环境 env
#' 用当前环境的 f
#' 传当前环境的 a
#' 

do.call ("f", list(as.name("a")), envir = env) # [1] 125
do.call ("f", list(quote(a)), envir = env) # [1] 125

#' 上述 2 行是: 
#' 在环境 env
#' 用该环境的 f
#' 传该环境的 a
#' 

do.call (f, list(as.name("a")), envir = env) # [1] 25
do.call (f, list(quote(a)), envir = env) # [1] 25

#' 上述 2 行是: 
#' 在环境 env
#' 用当前环境的 f
#' 传该环境的 a
#' 

eval (call ("f", a)) # [1] 4
eval (call ("f", quote(a))) # [1] 4

#' 上述 2 行是: 
#' 在环境 parent.frame()
#' 用该环境的 f
#' 传该环境的 a
#' 

eval (call ("f", a), envir = env) # [1] 8

#' 上述 1 行是: 
#' 在环境 env
#' 用该环境的 f
#' 传当前环境的 a
#' 

eval (call ("f", quote(a)), envir = env) # [1] 125

#' 上述 1 行是: 
#' 在环境 env
#' 用该环境的 f
#' 传该环境的 a
#' 
