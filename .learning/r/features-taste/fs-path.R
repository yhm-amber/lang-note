
#: tmp file
config_path = fs::file_temp(
	pattern = 'odbc_config_',
	tmp_dir = '/tmp/.drivers',
	ext = 'toml') |> print()
#| /tmp/.drivers/odbc_config_6a179107e9.toml

#: it will not create file/dir automatically
fs::file_exists(config_path)
#| /tmp/.drivers/odbc_config_6a179107e9.toml 
#|                                     FALSE 
fs::dir_exists(fs::path_dir(config_path))
#| /tmp/.drivers 
#|         FALSE 

#: create dir manually
fs::dir_create(fs::path_dir(config_path))
"Hey" |> readr::write_file(config_path)
fs::file_exists(config_path)
#| /tmp/.drivers/odbc_config_6a179107e9.toml 
#|                                      TRUE 

#: dir auto create util
mkdir_auto = \ (p) p |> magrittr::'%T>%'({ fs::dir_create(fs::path_dir(.)) })

#: try again
config_path = fs::file_temp(
	pattern = 'odbc_config_',
	tmp_dir = '/tmp/.drivers_AAA',
	ext = 'toml') |> print()
#| /tmp/.drivers_AAA/odbc_config_6a7295a4e4.toml

#: not exists for now
fs::dir_exists(fs::path_dir(config_path))
#| /tmp/.drivers_AAA 
#|             FALSE 

#: using dir auto create util
"Hey" |> readr::write_file(mkdir_auto(config_path))
#: see, created.
fs::dir_exists(fs::path_dir(config_path))
#| /tmp/.drivers_AAA 
#|              TRUE 

