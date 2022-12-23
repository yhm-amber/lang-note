let say_101 = do { 101 } ; $say_101 ## 101
do { 101 } ## 101

do {|x| $x + 101 } 1 ## 102
let add_1_101 = do {|x| $x + 101 } 1 ; $add_1_101 ## 102

let add_101 = do {|x| $x + 101 } ## Error: nu::shell::variable_not_found (https://docs.rs/nu-protocol/0.72.0/nu_protocol/enum.ShellError.html#variant.VariableNotFoundAtRuntime)
