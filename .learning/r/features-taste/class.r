
#' see: https://stackoverflow.com/questions/59914349/r-named-lists-and-description-lists/59917257#59917257
#' 
base::Sys.getenv (base::c ("R_HOME", "R_PAPERSIZE", "R_PRINTCMD", "HOST")) |> 
	magrittr::'%>%' (base::'class<-' ("Dlist")) |> 
	base::identity ()

