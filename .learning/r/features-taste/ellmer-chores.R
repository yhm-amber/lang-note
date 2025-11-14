
#: Setting API for chores plugin
options(.chores_chat = ellmer::chat_vllm(
	base_url = Sys.getenv("ABCLLM_BASE_URL"),
	api_key = Sys.getenv("ABCLLM_API_KEY"),
	model = Sys.getenv("ABCLLM_MODEL")))

#: Then you can select your function definition codes
#:  and Press CTRL-SHIFT-P then search and click "Chores"
#:  or Press a shortcut you've setted for "Chores", then
#:  click "roxygen" from helpers list in the pop-up sub-window to
#:  let the LLM generate doc-comments for this func.


#: You can also define your own helper.

#: Create an helper file
#: Here to create an expounder which output it's answer
#:  below the selected text (i.e., suffix).
chores::prompt_new(
	chore = "expounder", 
	interface = "suffix")

#: Run this command, RStudio will open a new .md file with a prompt template as its content.
#: You can edit the prompt template as you like, then save and run that to load changes.
chores::directory_load()

#: Then you can try this magik !!

#: You can open this file again by run
chores::prompt_edit("expounder")


#: Additionally, you can also add `tools` to your assistant

#: This can give a `pwd` tool to your assistant
#:  and any helpers are able to use it, as long as the selected prompt text
#:  makes the LLM (model behind the assistant) believe it should be use at this time.
'pwd' |> 
	ellmer::tool(
		fun = \ () { fs::path_wd() }, 
		name = _, 
		description = "Show work dir", 
		arguments = list(), 
		annotations = list()) |> 
	base::getOption('.chores_chat')$register_tool()

#: It's better to define a greate runner helper
#:  to execute tool(s) and gives you the result.

#~ Details see: ellmer-tools.R
#~ - Define R-Code tools using: `ellmer::tool`,
#~ - Give a R-Code tool to a chat using: `chat$register_tool`,
#~ - And to get the chat pointer which chores is using by using: `base::getOption('.chores_chat')`.


