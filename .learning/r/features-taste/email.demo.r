
#' emayili 
#' 
#'   Simple and fun.
#'   Have curry in it.
#' 
#' demo: 
#' 
{
	email = emayili::envelope(text = "OMG !!!!") |> 
		emayili::from("sender@mail.server.from") |> 
		emayili::to("receiver@mail.server.to") |> 
		emayili::subject("This is a plain text message!")

	email |> 
		emayili::server(
			host = "server.mail.co",
			port = 465,
			username = "account@some.mail.co",
			password = "(your passwd here)") (verbose = F) -> send_report
}

#' blastula 
#' 
#'   Much more prescriptive and careful.
#'   Markdown syntaxed text support and easy to insert image.
#'   Foot is simple to add and also md-supported.
#' 
#' demo: 
#' 
{
	img_path = base::system.file("img", "pexels-photo-267151.jpeg", package = "blastula")
	body_template = "
Hello,

This is a *great* picture I found when looking
for sun + cloud photos:

{blastula::add_image(file = img_path)}"
	
	#' Image will trans to base64 by `blastula::add_image`.
	#' 
	#' You can see preview by just enter `email` at R Studio console after create it.
	#' 
	email = blastula::compose_email(
		body = blastula::md(glue::glue(body_template)), 
		footer = blastula::md(glue::glue("Email sent on {blastula::add_readable_time()}.")))
	
	email |> 
		blastula::smtp_send(
			credentials = blastula::creds_envvar(
				user = base::Sys.getenv('SMTP_USER'), 
				pass_envvar = 'SMTP_PASSWORD', 
				host = "server.mail.co", 
				port = 465, 
				use_ssl  = T), 
			to = "receiver@mail.server.to", 
			from = "sender@mail.server.from", 
			subject = "Testing the `blastula::smtp_send()` function", 
			verbose = F) -> report.will_be_null_if_send...
}




#' mailR (Not recommended)
#' 
#'   Don't have more funny, careful, prescriptive, or md or foot support than the Aboves.
#'   It's not implemented by pure R (Based on Java) so might conflict with some other (such as other package also based on Java).
#' 
#' demo: Nothing.
#' 
{}
