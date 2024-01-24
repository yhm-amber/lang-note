library(magrittr); 

(\ (`%foo%`) 
{
	1 %>% (2 %foo% 3) (4) |> print () ; # [1] "2 3 , 1 4"
	(2 %foo% 3) (1, 4) |> print () ; # [1] "2 3 , 1 4"
	`%foo%` (2, 3) (1, 4) |> print () ; # [1] "2 3 , 1 4"
	
}) (\(a,b)\(x,y) paste (a,b,",",x,y)) ;
