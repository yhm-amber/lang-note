
expression (1 + 1) ;
expression (1   +   1) ;
expression (1+1) ;
# expression(1 + 1)

expression (1 + 1) |> eval () ; # [1] 2

"1+1" |> parse (text = _) ; # expression(1+1)
"1 + 1" |> parse (text = _) ; # expression(1 + 1)
"1   +   1" |> parse (text = _) ; # expression(1   +   1)


"1+1" |> parse (text = _) |> eval () ;
"1 + 1" |> parse (text = _) |> eval () ;
"1   +   1" |> parse (text = _) |> eval () ;
# [1] 2
