#' @name openurl_browser
#' @title Open URL in Browser with Flexible Modes
#' @description Open URL in Browser with Flexible Modes
#' @param url URL to open
#' @param web_mode Web mode to use. Default is from option 'browser.mode.web'.
#'   Options include 'utils::browseURL', 'rstudioapi::viewer', 'shiny.iframe'.
#' @param .more_hint Logical. Whether to show more hint message. Default is from option 'hint.more'.
#' @param .is_testing Logical. Whether in testing mode. Default is from option 'mode.test'.
#' @return Invisible result of the browser opening function.
#' @examples
#' \dontrun{
#' #: using utils::browseURL
#' openurl_browser('https://rosettacode.org')
#' openurl_browser('https://rosettacode.org', web_mode = utils::browseURL)
#' openurl_browser('https://rosettacode.org', web_mode = utils.browse.URL)
#' openurl_browser('https://rosettacode.org', web_mode = 'utils browse url')
#' openurl_browser('https://rosettacode.org', web_mode = utils ~browse~ url)
#' #: using rstudioapi::viewer
#' openurl_browser('https://rosettacode.org', web_mode = rstudioapi::viewer)
#' openurl_browser('https://rosettacode.org', web_mode = rstudioapi.viewer)
#' openurl_browser('https://rosettacode.org', web_mode = 'rstudioapi viewer')
#' openurl_browser('https://rosettacode.org', web_mode = ~~~ rstudioapi~ ~~ ~viewer)
#' #: using shiny iframe
#' openurl_browser('https://rosettacode.org', web_mode = shiny.iframe)
#' openurl_browser('https://rosettacode.org', web_mode = 'shiny iframe')
#' openurl_browser('https://rosettacode.org', web_mode = shiny:iframe)
#' openurl_browser('https://rosettacode.org', web_mode = shiny::iframe)
#' openurl_browser('https://rosettacode.org', web_mode = shiny:::iframe)
#' openurl_browser('https://rosettacode.org', web_mode = shiny: ~iframe)
#' }
openurl_browser = function (
		url, 
		web_mode = 'browser.mode.web' |> base::getOption(utils::browseURL), 
		.more_hint = 'hint.more' |> base::getOption(T), 
		.is_testing = 'mode.test' |> base::getOption(F)) 
{
	web_mode = base::deparse(base::substitute(web_mode))
	
	#: udf by: iframe in shiny
	.shiny_iframe = \ (url) shiny::runApp(shiny::shinyApp(
		ui = shiny::fluidPage(
			shiny::titlePanel("Shiny App in Non-Async: Need to close this window manually."),
			htmltools::tags$iframe(src = url, style = "width:100%; height:600px; border:none;")),
		server = \ (input, output) {}))
	
	open.browser = base::alist(
		utils::browseURL |> magrittr::'%T>%'({ usethis::ui_info(
			"Web mode {usethis::ui_value(web_mode)} not found ... using default {usethis::ui_value(base::deparse(base::substitute(.)))}") }), 
		'utils::browseURL' = utils::browseURL, 
		'rstudioapi::viewer' = rstudioapi::viewer, 
		'shiny.iframe' = .shiny_iframe) |> 
		magrittr::'%T>%'({ base::names(.) <- base::names(.) |> snakecase::to_snake_case() }) |> 
		base::append(base::list(EXPR = web_mode |> snakecase::to_snake_case()), after = 0L) |> 
		base::do.call(what = base::switch, args = _)
	
	usethis::ui_info(
		if (base::isTRUE(.more_hint)) "Opening browser with {usethis::ui_value(url)} ..." else 
		if (base::isTRUE(TRUE)) "Opening browser ...")
	if (base::isFALSE(.is_testing)) { .res = open.browser(url) }
	usethis::ui_done("Browser Done.")
	
	base::return(base::invisible(.res))
}
