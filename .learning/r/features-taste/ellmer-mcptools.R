#: Content of config to profile the R
#:  as a Mcp Server - stdio command mode

#% json
#| {
#|  "mcpServers": {
#|   "r-mcptools": {
#|    "command": "Rscript",
#|    "args": ["-e", "mcptools::mcp_server()"]
#|   }
#|  }
#| }

#: This config could be load by client code
mcptools::mcp_tools()
#: This will same as
mcptools::mcp_tools(config = '~/.config/mcptools/config.json')
#: So those content can be added into this file.
#: And which tool(s) can be returned will depends on the config. 

#: Every calling will build a list of tools
#:  about {mcptools}, so we can use it like:
chat$register_tools(mcptools::mcp_tools())
#: The obj `chat` here could made by such as `ellmer::chat_vllm()`.

#: After registering tools, we can see what tools are available:
chat$get_tools()

#: If your profiled command-args is: `Rscript -e 'mcptools::mcp_server()'`,
#:  you will get below:

#| $list_r_sessions
#| # <ellmer::ToolDef> list_r_sessions()
#| # @name: list_r_sessions
#| # @description: List the R sessions that are available to access. R sessions which have run `mcptools::mcp_session()` will appear here. In 
#| the output, start each session with 'Session #' and do NOT otherwise prefix any index numbers to the output. In general, do not use this 
#| tool unless asked to list or select a specific R session. Given the output of this tool, report the users to the user. Do NOT make a choice 
#| of R session based on the results of the tool and call select_r_session unless the user asks you to specifically.
#| # @convert: TRUE
#| #
#| function () 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "list_r_sessions")))
#| }
#| <environment: 0x5577058d1878>
#| 
#| $select_r_session
#| # <ellmer::ToolDef> select_r_session(session)
#| # @name: select_r_session
#| # @description: Choose the R session of interest. Use the `list_r_sessions` tool to discover potential sessions. In general, do not use this
#| tool unless asked to select a specific R session; the tools available to you have a default R session that is usually the one the user 
#| wants. Do not call this tool immediately after calling list_r_sessions unless you've been asked to select an R session and haven't yet 
#| called list_r_sessions. Your choice of session will persist after the tool is called; only call this tool more than once if you need to 
#| switch between sessions.
#| # @convert: TRUE
#| #
#| function (session) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "select_r_session")))
#| }
#| <environment: 0x557705942b68>
#| 

#: That means you can call the tool in it also:
chat$get_tools()$list_r_sessions()
#: And if you don't want it return a `NULL`, you need to run `mcptools::mcp_session()`
#:  in one session to specify it can be discovered (as a mcp server)
#:  by tools (such as this `list_r_sessions`) that returned by the profiled server.

#: If your profiled command-args is: `Rscript -e 'btw::btw_mcp_server()'`,
#:  your returning tools could be:

#| $btw_tool_env_describe_data_frame
#| # <ellmer::ToolDef> btw_tool_env_describe_data_frame(data_frame, package, format, max_rows, max_cols, `_intent`)
#| # @name: btw_tool_env_describe_data_frame
#| # @description: Show the data frame or table or get information about the structure of a data frame or table.
#| # @convert: TRUE
#| #
#| function (data_frame, package, format, max_rows, max_cols, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_env_describe_data_frame")))
#| }
#| <environment: 0x557701d488f0>
#| 
#| $btw_tool_docs_package_news
#| # <ellmer::ToolDef> btw_tool_docs_package_news(package_name, search_term, `_intent`)
#| # @name: btw_tool_docs_package_news
#| # @description: Read the release notes (NEWS) for a package.
#| 
#| Use this tool when you need to learn what changed in a package release, i.e. when code no longer works after a package update, or when the 
#| user asks to learn about new features.
#| 
#| If no search term is provided, the release notes for the current installed version are returned. If a search term is provided, the tool 
#| returns relevant entries in the NEWS file matching the search term from the most recent 5 versions of the package where the term is matched.
#| 
#| Use a search term to learn about recent changes to a function, feature or argument over the last few package releases. For example, if a 
#| user recently updated a package and asks why a function no longer works, you can use this tool to find out what changed in the package 
#| release notes.
#| # @convert: TRUE
#| #
#| function (package_name, search_term, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_docs_package_news")))
#| }
#| <environment: 0x5577079b1d40>
#| 
#| $btw_tool_docs_package_help_topics
#| # <ellmer::ToolDef> btw_tool_docs_package_help_topics(package_name, `_intent`)
#| # @name: btw_tool_docs_package_help_topics
#| # @description: Get available help topics for an R package.
#| # @convert: TRUE
#| #
#| function (package_name, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_docs_package_help_topics")))
#| }
#| <environment: 0x5577077711f8>
#| 
#| $btw_tool_docs_help_page
#| # <ellmer::ToolDef> btw_tool_docs_help_page(package_name, topic, `_intent`)
#| # @name: btw_tool_docs_help_page
#| # @description: Get help page from package.
#| # @convert: TRUE
#| #
#| function (package_name, topic, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_docs_help_page")))
#| }
#| <environment: 0x557707477000>
#| 
#| $btw_tool_docs_available_vignettes
#| # <ellmer::ToolDef> btw_tool_docs_available_vignettes(package_name, `_intent`)
#| # @name: btw_tool_docs_available_vignettes
#| # @description: List available vignettes for an R package. Vignettes are articles describing key concepts or features of an R package. 
#| Returns the listing as a JSON array of `vignette` and `title`. To read a vignette, use `btw_tool_docs_vignette(package_name, vignette)`.
#| # @convert: TRUE
#| #
#| function (package_name, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_docs_available_vignettes")))
#| }
#| <environment: 0x557707191b78>
#| 
#| $btw_tool_docs_vignette
#| # <ellmer::ToolDef> btw_tool_docs_vignette(package_name, vignette, `_intent`)
#| # @name: btw_tool_docs_vignette
#| # @description: Get a package vignette in plain text.
#| # @convert: TRUE
#| #
#| function (package_name, vignette, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_docs_vignette")))
#| }
#| <environment: 0x557706f54c20>
#| 
#| $btw_tool_env_describe_environment
#| # <ellmer::ToolDef> btw_tool_env_describe_environment(items, `_intent`)
#| # @name: btw_tool_env_describe_environment
#| # @description: List and describe items in the R session's global environment.
#| # @convert: TRUE
#| #
#| function (items, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_env_describe_environment")))
#| }
#| <environment: 0x557706c2fc38>
#| 
#| $btw_tool_files_code_search
#| # <ellmer::ToolDef> btw_tool_files_code_search(term, limit, case_sensitive, use_regex, show_lines, `_intent`)
#| # @name: btw_tool_files_code_search
#| # @description: Search code files in the project.
#| 
#| Use this tool to find references to specific code or terms in the project.
#| The tool returns a list of files and lines of code that match the search `term`.
#| `term` is the only required argument, only adjust the arguments if necessary.
#| 
#| Use the `btw_tool_files_read_text_file` tool, if available, to read the full content of a file found in this search.
#|       
#| # @convert: TRUE
#| #
#| function (term, limit, case_sensitive, use_regex, show_lines, 
#|     `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_files_code_search")))
#| }
#| <environment: 0x557706888230>
#| 
#| $btw_tool_files_list_files
#| # <ellmer::ToolDef> btw_tool_files_list_files(path, type, regexp, `_intent`)
#| # @name: btw_tool_files_list_files
#| # @description: List files or directories in the project.
#| 
#| WHEN TO USE:
#| * Use this tool to discover the file structure of a project.
#| * When you want to understand the project structure, use `type = "directory"` to list all directories.
#| * When you want to find a specific file, use `type = "file"` and `regexp` to filter files by name or extension.
#| 
#| CAUTION: Do not list all files in a project, instead prefer listing files in a specific directory with a `regexp` to filter to files of 
#| interest.
#|       
#| # @convert: TRUE
#| #
#| function (path, type, regexp, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_files_list_files")))
#| }
#| <environment: 0x5577064ed7f8>
#| 
#| $btw_tool_files_read_text_file
#| # <ellmer::ToolDef> btw_tool_files_read_text_file(path, line_start, line_end, `_intent`)
#| # @name: btw_tool_files_read_text_file
#| # @description: Read an entire text file.
#| # @convert: TRUE
#| #
#| function (path, line_start, line_end, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_files_read_text_file")))
#| }
#| <environment: 0x55770618b038>
#| 
#| $btw_tool_files_write_text_file
#| # <ellmer::ToolDef> btw_tool_files_write_text_file(path, content, `_intent`)
#| # @name: btw_tool_files_write_text_file
#| # @description: Write content to a text file.
#| 
#| If the file doesn't exist, it will be created, along with any necessary parent directories.
#| 
#| WHEN TO USE:
#| Use this tool only when the user has explicitly asked you to write or create a file.
#| Do not use for temporary or one-off content; prefer direct responses for those cases.
#| Consider checking with the user to ensure that the file path is correct and that they want to write to a file before calling this tool.
#| 
#| CAUTION:
#| This completely overwrites any existing file content.
#| To modify an existing file, first read its content using `btw_tool_files_read_text_file`, make your changes to the text, then write back the
#| complete modified content.
#| # @convert: TRUE
#| #
#| function (path, content, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_files_write_text_file")))
#| }
#| <environment: 0x557705e91538>
#| 
#| $btw_tool_search_packages
#| # <ellmer::ToolDef> btw_tool_search_packages(query, format, n_results, `_intent`)
#| # @name: btw_tool_search_packages
#| # @description: Search for an R package on CRAN.
#| 
#| ## Search Behavior
#| - Prioritizes exact phrase matches over individual words
#| - Falls back to word matching only when phrase matching fails
#| 
#| ## Query Strategy
#| - Submit separate searches for distinct concepts (e.g., `flights`, `airlines`)
#| - Break multi-concept queries (e.g., `flights airlines data API`) into multiple searches and synthesize results
#| - Search for single, specific technical terms that package authors would use
#| - If the search result includes more than a 1000 results, refine your query and try again.
#| 
#| ## Examples
#| Good: Search for `"permutation test"` or just `"permutation"`
#| Bad: Search for `"statistical analysis tools for permutation test"`
#| # @convert: TRUE
#| #
#| function (query, format, n_results, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_search_packages")))
#| }
#| <environment: 0x557705b67748>
#| 
#| $btw_tool_search_package_info
#| # <ellmer::ToolDef> btw_tool_search_package_info(package_name, `_intent`)
#| # @name: btw_tool_search_package_info
#| # @description: Describe a CRAN package. Shows the title, description, dependencies and author information for a package on CRAN, regardless
#| of whether the package is installed or not.
#| # @convert: TRUE
#| #
#| function (package_name, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_search_package_info")))
#| }
#| <environment: 0x55770595dd30>
#| 
#| $btw_tool_session_check_package_installed
#| # <ellmer::ToolDef> btw_tool_session_check_package_installed(package_name, `_intent`)
#| # @name: btw_tool_session_check_package_installed
#| # @description: Check if a package is installed in the current session.
#| # @convert: TRUE
#| #
#| function (package_name, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_session_check_package_installed")))
#| }
#| <environment: 0x55770577f630>
#| 
#| $btw_tool_session_platform_info
#| # <ellmer::ToolDef> btw_tool_session_platform_info(`_intent`)
#| # @name: btw_tool_session_platform_info
#| # @description: Describes the R version, operating system, language and locale settings for the user's system.
#| # @convert: TRUE
#| #
#| function (`_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_session_platform_info")))
#| }
#| <environment: 0x557705652508>
#| 
#| $btw_tool_session_package_info
#| # <ellmer::ToolDef> btw_tool_session_package_info(packages, dependencies, `_intent`)
#| # @name: btw_tool_session_package_info
#| # @description: Verify that a specific package is installed, or find out which packages are in use in the current session. As a last resort,
#| this function can also list all installed packages.
#| # @convert: TRUE
#| #
#| function (packages, dependencies, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_session_package_info")))
#| }
#| <environment: 0x55770522a250>
#| 
#| $btw_tool_web_read_url
#| # <ellmer::ToolDef> btw_tool_web_read_url(url, `_intent`)
#| # @name: btw_tool_web_read_url
#| # @description: Read a web page and convert it to Markdown format.
#| 
#| This tool fetches the content of a web page and returns it as a simplified Markdown representation.
#| 
#| WHEN TO USE: Use this tool when you need to access and analyze the content of a web page, e.g. when the user asks you to read the contents 
#| of a webpage.
#| # @convert: TRUE
#| #
#| function (url, `_intent`) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "btw_tool_web_read_url")))
#| }
#| <environment: 0x557704fdba98>
#| 
#| $list_r_sessions
#| # <ellmer::ToolDef> list_r_sessions()
#| # @name: list_r_sessions
#| # @description: List the R sessions that are available to access. R sessions which have run `mcptools::mcp_session()` will appear here. In 
#| the output, start each session with 'Session #' and do NOT otherwise prefix any index numbers to the output. In general, do not use this 
#| tool unless asked to list or select a specific R session. Given the output of this tool, report the users to the user. Do NOT make a choice 
#| of R session based on the results of the tool and call select_r_session unless the user asks you to specifically.
#| # @convert: TRUE
#| #
#| function () 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "list_r_sessions")))
#| }
#| <environment: 0x557704eaf0a8>
#| 
#| $select_r_session
#| # <ellmer::ToolDef> select_r_session(session)
#| # @name: select_r_session
#| # @description: Choose the R session of interest. Use the `list_r_sessions` tool to discover potential sessions. In general, do not use this
#| tool unless asked to select a specific R session; the tools available to you have a default R session that is usually the one the user 
#| wants. Do not call this tool immediately after calling list_r_sessions unless you've been asked to select an R session and haven't yet 
#| called list_r_sessions. Your choice of session will persist after the tool is called; only call this tool more than once if you need to 
#| switch between sessions.
#| # @convert: TRUE
#| #
#| function (session) 
#| {
#|     call_info <- match.call()
#|     tool_args <- lapply(call_info[-1], eval)
#|     do.call(call_tool, c(tool_args, list(server = "r-mcptools", 
#|         tool = "select_r_session")))
#| }
#| <environment: 0x557704d35d08>
#| 

#: Also you need to specify session
#:  by run this in a session which you want to specify:
btw::btw_mcp_session()
