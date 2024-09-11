#' emayili demo: 
#' 

email <- emayili::envelope(text = "OMG !!!!") |> 
	emayili::from("sender@mail.server.from") |> 
	emayili::to("receiver@mail.server.to") |> 
	emayili::subject("This is a plain text message!")

email |> 
	emayili::server(
		host = "server.mail.co",
		port = 465,
		username = "account@some.mail.co",
		password = "(your passwd here)") (verbose = F) -> send_report
