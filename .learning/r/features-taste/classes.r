
( \()
{
	Pos <- setClass("Pos", slots = 
		c(
			latitude = "numeric", 
			longitude = "numeric", 
			altitude = "numeric", 
			f = "function")) ;
	
	Pos(latitude = 11, longitude = 22, altitude = 33, f = \() altitude)@altitude ; # [1] 33
	Pos(latitude = 11, longitude = 22, altitude = 33, f = \() altitude)@f ; # \() altitude
	
	Pos(latitude = 11, longitude = 22, altitude = 33, f = \() altitude)@f() ;
	#messages# Error in Pos(latitude = 11, longitude = 22, altitude = 33, f = function() altitude)@f() : 
	#messages#   object 'altitude' not found
	
	Pos(latitude = 11, longitude = 22, altitude = 33, f = \() z)@f() ;
	#messages# Error in Pos(latitude = 11, longitude = 22, altitude = 33, f = function() z)@f() : 
	#messages#   object 'z' not found
	
	Pos(latitude = 11, longitude = 22, altitude = 33, f = \() z)@f -> ff ;
	
	ff() ;
	#messages# Error in ff() : object 'z' not found
	
	z = 1;
	ff() ; # [1] 1
	
}) ()
