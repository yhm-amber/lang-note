
chat = ellmer::chat_vllm(
	base_url = Sys.getenv("ABCLLM_BASE_URL"),
	api_key = Sys.getenv("ABCLLM_API_KEY"),
	model = Sys.getenv("ABCLLM_MODEL"))

chat #> <Chat VLLM/abc-32b turns=0 tokens=0/0>


#: using DF as data source
starwars_df = dplyr::starwars |> dplyr::select(seq(11))
starwars_df |> querychat::querychat_app(client = chat)
#! This will block R Console, and a chat app
#!  will open in the RStudio Viewer pane
#!  or your default web browser.

#: using DB as data source (and that's also a way to loading an arrow ds)
starwars_arrow = starwars_df |> arrow::as_arrow_table()
con = DBI::dbConnect(RSQLite::SQLite(), ":memory:")
con |> DBI::dbWriteTableArrow('starwars_arrow', starwars_arrow)
con |> 
	querychat::querychat_data_source(table_name = 'starwars_arrow') |> 
	querychat::querychat_app(client = chat)
#! This will block R Console, and a chat app
#!  will open in the RStudio Viewer pane
#!  or your default web browser.


