
`%characters.cutter%` = 
#' learn by: 
#' https://stackoverflow.com/a/47670127
#' 
\ (pattern.a, pattern.b) 
\ (x) x |> 
strsplit(
	paste0("(?=[",pattern.a
		,"])(?<=[",pattern.b
		,"])|(?=[",pattern.b
		,"])(?<=[",pattern.a
		,"])")
	, perl=TRUE) ;

cut.letter.number = "A-Za-z" %characters.cutter% "0-9" ;



"ABC123" |> cut.letter.number () |> print ();
## [[1]]
## [1] "ABC" "123"

"ABC_a2_a3" |> cut.letter.number () |> print ();
## [[1]]
## [1] "ABC_a" "2_a"   "3"

"A1BC_a2_a3" |> cut.letter.number () |> print ();
## [[1]]
## [1] "A"    "1"    "BC_a" "2_a"  "3"

"ABC_123" |> cut.letter.number () |> print ();
## [[1]]
## [1] "ABC_123"

"ABC_123" |> ("A-Za-z_" %characters.cutter% "0-9") () |> print ();
"ABC_123" |> ("0-9" %characters.cutter% "A-Za-z_") () |> print ();

## [[1]]
## [1] "ABC_" "123"

"1-1-ABC_12.3" |> ("0-9\\." %characters.cutter% "A-Za-z_\\-") () |> print ();
## [[1]]
## [1] "1"     "-"     "1"     "-ABC_" "12.3"

"1-1-ABC_12.3" |> ("0-9\\.\\-" %characters.cutter% "A-Za-z_\\-") () |> print ();
## [[1]]
## [1] "1"    "-"    "1"    "-"    "ABC_" "12.3"
