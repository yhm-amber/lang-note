
aa = \ (a, ...) list(a = a, ...)
1 |> arpr::iff(T, aa, x = 2, z = 3) |> str()
#| List of 3
#|  $ a: num 1
#|  $ x: num 2
#|  $ z: num 3

ab = \ (a, b, ...) list(a = a, b = b, ...)
1 |> arpr::iff(T, ab, x = 2, z = 3, 4) |> str()
#| List of 4
#|  $ a: num 1
#|  $ b: num 4
#|  $ x: num 2
#|  $ z: num 3


#: 当 arpr::iff 之参二 test 通过，
#: 则参一 obj 为参三 fun 之一参所入、
#: 参余 ... 处所写如入参三 fun 其后诸参所作。

