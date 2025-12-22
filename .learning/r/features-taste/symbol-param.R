
#: Trans a symbol to its name string
base::deparse(base::substitute(A)) #> "A"

#: Using on param
as.text.param = \ (symb) 
{
	symb_astext = base::deparse(base::substitute(symb))
	usethis::ui_info("The param as text is: {usethis::ui_value(symb_astext)}")
	base::return(base::invisible(symb_astext))
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


