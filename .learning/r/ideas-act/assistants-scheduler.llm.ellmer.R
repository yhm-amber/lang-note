{
	worker_assistant = ellmer::tool(
		fun = \ (role, ask) 
		{
			role = print(role) |> utils::capture.output() |> paste(collapse = '\n')
			ask = print(ask) |> utils::capture.output() |> paste(collapse = '\n')
			
			chat = ellmer::chat_vllm(
				base_url = Sys.getenv("PROTON_BASE_URL"),
				# api_key = Sys.getenv("PROTON_API_KEY"),
				credentials = \ () Sys.getenv("PROTON_API_KEY"),
				model = Sys.getenv("PROTON_MODEL"))
			chat$set_system_prompt(role)
			chat$chat(ask) |> as.character()
		}, 
		name = 'worker_assistant', 
		description = '
		Using to invoke another llm-ai assistant for a specific work
		 (Professional, Special role assistant, some Erudite/learned people, or Experts in a specific field),
		 set its role and give an input ask, then you\'ll get response(s).', 
		arguments = list(
			role = ellmer::type_string('
			Specify a role(s), require(s) and/or knowledge(s) for this llm assistant.
			Just give your example(s) that you want this worker response you what when you input what.'), 
			ask = ellmer::type_string('
			Put what you want to ask here!
			You have only one turn so say all messages plz!')
		)
	)
	
	assistant_scheduler = ellmer::chat_vllm(
		system_prompt = '
		You are a scheduler for any of llm-ai assistant. 
		You can and must always call the worker assistant to get helpings.
		You have the jurisdiction to judge whether the worker(s)\' answer are correct or not.
		Finally you will give your reply.
		
		You may often need to do that: ask expert worker A, get the answer, then consider
		 whether it\'s necessary to ask expert worker B, similarly it might be necessary 
		 to consult expert C, etc.
		
		As the scheduler, your main focus will be deciding which helpers to consult.',
		base_url = Sys.getenv("PROTON_BASE_URL"),
		# api_key = Sys.getenv("PROTON_API_KEY"),
		credentials = \ () Sys.getenv("PROTON_API_KEY"),
		model = Sys.getenv("PROTON_MODEL"))
	
	assistant_scheduler$register_tool(worker_assistant)
}

{
	assistant_scheduler$set_turns(list())
	assistant_scheduler$chat('让一个专家问一个问题然后根据提问让另外三个专家回答问题。')
}
