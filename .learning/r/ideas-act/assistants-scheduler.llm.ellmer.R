
{
	new.ellmer_chat = \ (...) ... |> ellmer::chat_vllm(
		base_url = Sys.getenv("VLLM_BASE_URL"),
		# api_key = Sys.getenv("VLLM_API_KEY"),
		credentials = \ () Sys.getenv("VLLM_API_KEY"),
		model = Sys.getenv("VLLM_MODEL"))
	
	worker_assistant = (\ (role, ask) 
	{
		{
			role = print(role) |> utils::capture.output() |> paste(collapse = '\n')
			ask = print(ask) |> utils::capture.output() |> paste(collapse = '\n')
		}
		
		chat = new.ellmer_chat(system_prompt = role)
		# chat$set_system_prompt(role)
		chat$chat(ask)
		
		{
			print(chat) |> utils::capture.output() |> paste(collapse = '\n')
		}
	}) |> ellmer::tool(
		fun = _, 
		name = 'worker_assistant', 
		description = '
		Using to invoke another llm-ai assistant for a specific work
		 (Professional, Special role assistant, some Erudite/learned people, or Experts in a specific field),
		 set its role and give an input ask, then you\'ll get response(s).
		', 
		arguments = list(
			role = ellmer::type_string('
			Specify a role(s), require(s) and/or knowledge(s) for this llm assistant.
			Just give your example(s) that you want this worker response you what when you input what.
			'), 
			ask = ellmer::type_string('
			Put what you want to ask here!
			You have only one turn so say all messages plz!
			')))
	
	assistant_scheduler = new.ellmer_chat(
		system_prompt = '
		You are a scheduler for any of llm-ai assistant. 
		You can and must always call the worker assistant to get helpings.
		You have the jurisdiction to judge whether the worker(s)\' answer are correct or not.
		
		You may often need to do that: ask expert worker A, get the answer, then consider
		 whether it\'s necessary to ask expert worker B, similarly it might be necessary 
		 to consult expert C, etc.
		
		As the scheduler, your main focus will be deciding which helpers to consult.
		And finally, you must give your idea, not repeat the worker(s)\'.
		Workers just help you (to make some content or answer), but your user just need your opinions.
		
		Ultimately, it will be **your subjectivity** that is reflected !!
		')
	
	assistant_scheduler$register_tool(worker_assistant)
}

{
	assistant_scheduler$set_turns(list())
	assistant_scheduler$chat('让一个助手生成提问、再让另外两个解答。')
}


#| 为了更好地完成这个任务，我将首先创建一个问题，然后分别咨询两个专家来获取他们的见解。让我们开始吧。
#| 
#| 首先，我将生成一个关于人工智能伦理的问题。
#| 
#| ◯ [tool call] worker_assistant(role = "创意写作专家", ask = "请帮我创造一个关于人工智能伦理的有趣问题。")
#| [1] "如果一台人工智能机器被编程为拯救尽可能多的生命，在一场不可避免的事故中，它必须选择救五名行人还是救一名车上的司机，而司机是开发这台机器的科学家，他还在不断研究如何让人工智能更好地服务人类社会。那么，这台机器会如何做出决定？这个决策背后又隐藏着哪些深层次的人工智能伦理问题？"
#| ● #> <Chat VLLM/qwen25-32b-awq turns=3 input=37 output=84>
#|   #> ── system
#| ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#|   #> [1] "创意写作专家"
#|   #> ── user
#| ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#|   #> [1] "请帮我创造一个关于人工智能伦理的有趣问题。"
#|   #> …
#| 我们有了一个有趣的问题：“如果一台人工智能机器被编程为拯救尽可能多的生命，在一场不可避免的事故中，它必须选择救五名行人还是救一名车上的司机，而这名司机是一位致力于改善人工智能服务人类社会的研究者。在这种情况下，这台机器会如何做出决定？这一决策背后又有哪些深刻的人工智能伦理问题？”
#| 
#| 接下来，我将邀请两位专家对此进行探讨：一位是专注于技术伦理的哲学家，另一位则是人工智能领域的工程师。他们将从不同的角度为我们提供见解。
#| 
#| 
#| ◯ [tool call] worker_assistant(role = list("技术伦理的哲学家", "人工智能领域的工程师"), ...)
#| 这是一个非常复杂且具有挑战性的问题，涉及到多个层次的技术伦理和道德哲学讨论。
#| 
#| 首先，从技术伦理的角度来看，这台人工智能机器被编程为拯救尽可能多的生命。这意味着它的主要目标是最大化生命的保存数量。在上述情景下，根据这个编程逻辑，它可能会选择救五名行人而不是一名司机。然而，这样的决策忽视了司机的独特价值——他是一位致力于改善人工智能服务人类社会的研究者。这引发了关于个体价值与群体利益之间的平衡问题。
#| 
#| 其次，这一情境触及了经典的“电车难题”（Trolley Problem），这是伦理学中的一个著名思想实验，旨在探讨不同道德原则之间的冲突。例如，功利主义强调最大多数人的最大幸福，而德行伦理则更注重个人品德和责任。在这个案例中，人工智能面临着类似的选择：是否应该牺牲少数人的生命以挽救更多人的生命？
#| 
#| 最后，这一决策背后涉及的人工智能伦理问题包括但不限于：
#| 
#| - **编程伦理**：机器的编程决定了其行为模式，但在面对复杂道德决策时，这些编程规则可能显得过于简化或不充分。
#| - **价值判断**：如何在算法层面量化和比较不同生命的价值，是一个极为棘手的问题。
#| - **透明度与可解释性**：决策过程需要高度透明，以便人类能够理解并评估机器的行为是否符合伦理标准。
#| - **责任归属**：当机器做出有争议的决策时，谁应对此负责？是设计者、编程者还是拥有者？
#| 
#| 这些问题没有简单的答案，需要跨学科的合作来探索解决之道。
#| ● #> <Chat VLLM/qwen25-32b-awq turns=3 input=113 output=325>
#|   #> ── system
#| ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
#|   #> [[1]]
#|   #> [1] "技术伦理的哲学家"
#|   #>
#|   #> …
#| 从两位专家的回答中可以看出，这个问题确实非常复杂，涉及到了多个层面的考虑。
#| 
#| 一方面，从技术伦理的角度看，虽然机器的编程目的是为了拯救尽可能多的生命，但在这种特殊情况下，司机作为一位致力于改善人工智能服务人类社会的研究者的独特价值，使得简单地选择救更多人显得不够全面。这揭示了在设计人工智能系统时，我们需要更加深入地思考如何平衡群体利益和个人价值之间的关系。
#| 
#| 另一方面，从工程师的角度看，这种情境实际上是对经典“电车难题”的一种现代演绎，突显了当前人工智能面临的道德困境。编程伦理、价值判断、透明度与可解释性以及责任归属等问题都需要我们在技术发展的同时，加强伦理规范和法律框架的建设。
#| 
#| 综合来看，我认为在处理这类复杂伦理问题时，我们需要建立一套更为完善的伦理指导原则和技术规范，确保人工智能在各种情境下的决策都能够得到合理的解释，并且能够兼顾到不同个体的价值。同时，增强系统的透明度，使人们可以理解和信任人工智能的决策过程，也是至关重要的。
