
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

(expression (\ (x) x) |> eval ()) (0)
(expression (\ (x) x) |> eval (expr = _)) (0)
(parse (text = "\\ (x) x") |> eval ()) (0)
# [1] 0
