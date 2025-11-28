
#: Its param won't be eval before it be choosed.
type |> base::switch(wee = fn_a(), woo = fn_b(type))

#: means this can same as
if (type |> base::identical('wee')) fn_a() else 
if (type |> base::identical('woo')) fn_b(type) else 
NULL ;

#: Also type can be index number
#:  rather than name-specify
#:  like the aboves.

#. Thanks for the codes of fn-define
#.  of the `type` param in fn:mcp_server 
#.  in repo src-file gh:posit-dev/mcptools@main/R/server.R
