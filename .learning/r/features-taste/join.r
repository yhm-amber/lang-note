
paste (c("a","b","c"), 1:3) ; # [1] "a 1" "b 2" "c 3"

paste ("a","b") ; # [1] "a b"
paste (c("a","b"), c("c","d")) ; # [1] "a c" "b d"
paste (c("a","b","c"), 1:3) ; # [1] "a 1" "b 2" "c 3"

paste ("x", 1:3, sep="~", collapse=",") ; # [1] "x~1,x~2,x~3"
paste (paste ("x", 1:3, sep="~"), collapse=",") ; # [1] "x~1,x~2,x~3"

paste ("a","b", sep=":", collapse=",") ; # [1] "a:b"
paste (c("a","b"),c("c","d"), sep=":", collapse=",") ; # [1] "a:c,b:d"
