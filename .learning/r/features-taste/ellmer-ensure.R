options(
	.ensure_fn = "chat_vllm", 
	.ensure_args = list(
		base_url = Sys.getenv("VLLM_BASE_URL"), 
		credentials = \ () Sys.getenv("VLLM_API_KEY"), 
		model = Sys.getenv("VLLM_MODEL")))

#: This one don't have `.ensure_chat` option support.
#: Then you can press [Addins > ENSURE > ensure: Test R code]
#:  to making a testthat for current active R script file
#:  under the "R" path of a R Package project.
