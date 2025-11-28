
#: Prepare chatlas.Chat object
import chatlas, os
chat = chatlas.ChatGroq(
	base_url = os.getenv("VLLM_BASE_URL"),
	api_key = os.getenv("VLLM_API_KEY"),
	model = os.getenv("VLLM_MODEL")))

#: Prepare sqlalchemy engine
from sqlalchemy import create_engine
engine = create_engine('xyz://...')

#: Create qc
from querychat import QueryChat
qc = QueryChat(
	data_source = engine, 
	table_name = 'starwars', 
	client = chat)
#: run `?QueryChat` can see help.

#: Got the shiny app!
app = qc.app()

#: See it in jupyter
import threading, shiny
thread = threading.Thread(target = lambda: shiny.run_app(app))
thread.start()

#| INFO:     Started server process [7767]
#| INFO:     Waiting for application startup.
#| INFO:     Application startup complete.
#| INFO:     Uvicorn running on https://positworkbench.abc.xyz/s/6eabd121f27ed62433b966d0d/p/02afd00d/ (Press CTRL+C to quit)

#: Here, `shiny.run_app(app)` same as `app.run()`, but more clearly.
