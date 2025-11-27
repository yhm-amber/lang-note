
# todo: test
type |> base::switch(wee = fn_a(), woo = fn_b(type))

# should same as
if (type |> base::identical('wee')) fn_a() else 
if (type |> base::identical('woo')) fn_b(type) else 
NULL ;
