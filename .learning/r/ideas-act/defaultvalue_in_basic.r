
default_of_basic = 
function (val) class (val) |> 
	base::head (1) |> 
	base::paste ('(1)') |> 
	base::parse (text = _) |> 
	base::eval ()

default_of_basic (lubridate::as_datetime(999)) # [1] "1970-01-01 UTC"
default_of_basic (NA_POSIXct_) # [1] "1970-01-01 UTC"
default_of_basic (lubridate::as_date(999)) # [1] NA
default_of_basic (NA_Date_) # [1] NA
default_of_basic (NA) # [1] FALSE
default_of_basic (default_of_basic (NA_Date_)) # [1] NA
default_of_basic (42L) # [1] 0
default_of_basic (666) # [1] 0
default_of_basic (NA_complex_) # [1] 0+0i
default_of_basic (NA_character_) # [1] ""
default_of_basic (NaN) # [1] 0
default_of_basic (logical (0)) # [1] FALSE
default_of_basic (character (0)) # [1] ""
default_of_basic (complex (0)) # [1] 0+0i
default_of_basic (integer (0)) # [1] 0
