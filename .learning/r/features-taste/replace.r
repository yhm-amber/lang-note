gsub(';', ',', "a, b; c") ; # [1] "a, b, c"
gsub(';', ',', "a, b; c", fixed=TRUE) ; # [1] "a, b, c"
gsub(';', ',', "a, b; c", fixed=FALSE) ; # [1] "a, b, c"
