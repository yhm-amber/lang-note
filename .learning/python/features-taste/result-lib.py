#: simplest import
from result import as_result

#: use for already existed func
@as_result(ZeroDivisionError)
def onediv(x): return 1 // x
#: ... or in lambda style
onediv = as_result(ZeroDivisionError)(lambda x: 1 // x)

#: Taste effect: 
print(onediv(10)) #> Ok(0)
print(onediv(1))  #> Ok(1)
print(onediv(0))  #> Err(ZeroDivisionError('integer division or modulo by zero'))

#: Check type: 
type(onediv(1)) #> result.result.Ok
type(onediv(0)) #> result.result.Err

#: repo/gh: rustedpy/result.git
#: pip/pypi: pypi.org/project/result/ {: pip install -U -- result :}

