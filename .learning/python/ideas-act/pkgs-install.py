
import importlib

subprocess = importlib.import_module("subprocess")
sys = importlib.import_module("sys")

install_pkgs = lambda packages: subprocess.check_call([sys.executable, "-m", "pip", "install", "--"] + packages)



import importlib
install_pkgs = lambda packages: (
	subprocess := importlib.import_module("subprocess"), 
	sys := importlib.import_module("sys"), 
	subprocess.check_call([sys.executable, "-m", "pip", "install", "--"] + packages))[-1]


import importlib
install_pkgs = (lambda sys: (lambda subprocess: (
	lambda packages: subprocess.check_call([sys.executable, "-m", "pip", "install", "--"] + packages)
)) (importlib.import_module("subprocess"))) (importlib.import_module("sys"))


# install_pkgs(['pip','wheel'])

