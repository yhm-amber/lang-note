
#' see: https://stackoverflow.com/questions/59914349/r-named-lists-and-description-lists/59917257#59917257
#' 
#' 更改 class 属性，可以影响对其应用方法性函数时的效果，在这里可以看到它被（自动地）应用 print 函数时反应的不同。
#' 
base::Sys.getenv (base::c ("R_HOME", "R_PAPERSIZE", "R_PRINTCMD", "HOST")) |> 
	magrittr::'%>%' (base::'class<-' ("Dlist")) |> 
	base::identity ()

