as.Date(c("12/6/2022", "1/1/2023"), format="%m/%d/%Y") ; # [1] "2022-12-06" "2023-01-01"

typeof (as.Date(c("12/6/2022", "1/1/2023"), format="%m/%d/%Y")) ; # [1] "double"
class (as.Date(c("12/6/2022", "1/1/2023"), format="%m/%d/%Y")) ; # [1] "Date"

as.POSIXct ("1991-01-02") ; # [1] "1991-01-02 UTC"
as.character (as.POSIXct ("1991-01-02")) ; # [1] "1991-01-02"
as.character (as.POSIXct ("1991-01-02"), format='%m/%d/%Y') ; # [1] "01/02/1991"

class (as.POSIXct ("1991-01-02")) ; # [1] "POSIXct" "POSIXt" 
typeof (as.POSIXct ("1991-01-02")) ; # [1] "double"

class (as.character (as.POSIXct ("1991-01-02"))) ; # [1] "character"
typeof (as.character (as.POSIXct ("1991-01-02"))) ; # [1] "character"

