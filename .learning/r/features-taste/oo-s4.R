
# create s4 class
# '<class.name>' |> methods::setClass(contains = '<extended.supclass>', slots = <new properties>)
'XDBConnection' |> methods::setClass(
	slots = base::list(
		workspace = "character",
		workrname = "character"),
	contains = 'DBIConnection')

# add method for s4 class
# '<method_name>' |> methods::setMethod('<class.name>', \ (<objname_formal>, ...) { ... })
'dbIsValid' |> methods::setMethod('XDBConnection', \ (dbObj, ...) { TRUE })

# then you can
xdbconn |> DBI::dbIsValid()

# Here `class(xdbconn)` should have `"XDBConnection"`, this can created by some other function
#  or by `methods::new('<class.name>')` in directly.
# And here `'XDBConnection'` should be subclass of `'DBIConnection'`.


# And s3 oo system is just using special func names to specified as method ...
# <method_name> <- \ (self, ...) { base::UseMethod('<method_name>') }
# <method_name>.<classname.A> <- \ (self, ...) { ... }
# <method_name>.<classname.B> <- \ (self, ...) { ... }
# ...
# Like: 
# '<method_name>' |> methods::setMethod("<classname.A>", \ (self, ...) { ... })
# '<method_name>' |> methods::setMethod("<classname.B>", \ (self, ...) { ... })
# ...

