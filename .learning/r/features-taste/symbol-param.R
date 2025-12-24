
#: Trans a symbol to its name string
base::deparse(base::substitute(A)) #> "A"

#: Using on param
as.text.param = \ (expr) 
{
	expr_astext = base::deparse(base::substitute(expr))
	usethis::ui_info("The param as text is: {usethis::ui_value(expr_astextx}")
	base::return(base::invisible(expr_astextx)
}

#: Try
wooo = 12345
as.text.param(wooo) |> print() #> "wooo"
#| ℹ The param as text is: 'wooo'

#: It's okay!

#: More

as.text.param(c(a,b,ccc)) |> print()
#| ℹ The param as text is: 'c(a, b, ccc)'
#| [1] "c(a, b, ccc)"
as.text.param(A + b) |> print()
#| ℹ The param as text is: 'A + b'
#| [1] "A + b"
as.text.param(A+-b) |> print()
#| ℹ The param as text is: 'A + -b'
#| [1] "A + -b"
as.text.param(c(a,b,ccc,1)) |> print()
#| ℹ The param as text is: 'c(a, b, ccc, 1)'
#| [1] "c(a, b, ccc, 1)"
as.text.param(list(base::c(a,b),ccc,1)) |> print()
#| ℹ The param as text is: 'list(base::c(a, b), ccc, 1)'
#| [1] "list(base::c(a, b), ccc, 1)"
as.text.param(base::list(base::c(a,b),ccc,1)) |> print()
#| ℹ The param as text is: 'base::list(base::c(a, b), ccc, 1)'
#| [1] "base::list(base::c(a, b), ccc, 1)"

#: Just expression codings in param
#:  becoming it's text here !!


#: rlang - symb & expr

#: Using basic: inner function define
param_exprs_catch = function (...) rlang::enexprs(...)
param_symbs_catch = function (...) rlang::ensyms(...)
#: Those will return a list of expression(s) / symbol(s)

#: Trans more param to text
param_exprs_astext = function (..., .map_fn = purrr::map_chr) rlang::enexprs(...) |> .map_fn(base::deparse)
param_symbs_astext = function (..., .map_fn = purrr::map_chr) rlang::ensyms(...) |> .map_fn(base::deparse)

#| > param_exprs_astext(a = a+-b, c*-d)
#|        a          
#| "a + -b" "c * -d" 
#| > param_symbs_astext(x = a, y = b, c) #: `rlang::ensyms` can only catch symbol(s), expression(s) could met error.
#|   x   y     
#| "a" "b" "c" 


