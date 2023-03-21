## all same these:
## 

# :-1
quote [(:do, (IO.puts "aa";IO.puts "bb";) )] ## quote( [(:do, (IO.puts "aa";IO.puts "bb";) )] )

# :0
quote [do: (IO.puts "aa";IO.puts "bb";)] ## quote( [do: (IO.puts "aa";IO.puts "bb";)] )

# :1
quote do: (IO.puts "aa";IO.puts "bb";)

# :2
quote do: (IO.puts "aa";IO.puts "bb")

# :3
quote do: (
    IO.puts "aa" ;
    IO.puts "bb" )

# :4
quote do:
(
    IO.puts "aa" ;
    IO.puts "bb" ;
    )

# :5
quote do:
(
    IO.puts "aa"
    IO.puts "bb"
)

# :6
quote do

    IO.puts "aa"
    IO.puts "bb"
end

# :7
quote do IO.puts "aa" ; IO.puts "bb" ; end

# :8
quote do IO.puts "aa" ; IO.puts "bb" end



########

IO.puts """
Erlang/OTP 25 [erts-13.1.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.14.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> quote do: (IO.puts "aa";IO.puts "bb")
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(2)> quote do: (IO.puts "aa")             
{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}
iex(3)> quote do: IO.puts "aa"  
{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}
iex(4)> quote do              
...(4)> IO.puts "aa";IO.puts "bb"
...(4)> end
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(5)> quote do                 
...(5)> IO.puts "aa";            
...(5)> IO.puts "bb";             
...(5)> end
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(6)> quote do     
...(6)> IO.puts "aa" 
...(6)> IO.puts "bb" 
...(6)> end
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(7)> quote do: (IO.puts "aa";IO.puts "bb";)
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(8)> quote do:
...(8)> (
...(8)>     IO.puts "aa" ;
...(8)>     IO.puts "bb" ;
...(8)>     )
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(9)> quote do:
...(9)> (
...(9)>     IO.puts "aa"
...(9)>     IO.puts "bb"
...(9)> )
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(10)> 
"""

####

IO.puts """
Erlang/OTP 25 [erts-13.1.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.14.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> quote do: quote do: (IO.puts "aa";IO.puts "bb";)
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(2)> quote do:                                       
...(2)> quote do: (IO.puts "aa";IO.puts "bb";)
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(3)> quote do:                             
...(3)> quote do: (IO.puts "aa";IO.puts "bb") 
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(4)> quote do:                            
...(4)> quote do:
...(4)> (
...(4)>     IO.puts "aa" ;
...(4)>     IO.puts "bb" ;
...(4)>     )
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(5)> quote do:         
...(5)> quote do
...(5)> 
...(5)>     IO.puts "aa"
...(5)>     IO.puts "bb"
...(5)> end
** (CompileError) iex:6: undefined function quote/0 (there is no such import)
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:603: :elixir_expand.mapfold/5
    (elixir 1.14.2) src/elixir_expand.erl:596: :elixir_expand.expand_args/3
    (elixir 1.14.2) src/elixir_expand.erl:421: :elixir_expand.expand/3
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:519: :elixir_expand.expand_list/5
    (elixir 1.14.2) src/elixir_expand.erl:429: :elixir_expand.expand/3
iex(5)> quote do:         
...(5)> (
...(5)> quote do
...(5)> 
...(5)>     IO.puts "aa"
...(5)>     IO.puts "bb"
...(5)> end)
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(6)> quote do:       
...(6)> quote do
...(6)> 
...(6)>     IO.puts "aa" ; IO.puts "bb"
...(6)> end
** (CompileError) iex:7: undefined function quote/0 (there is no such import)
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:603: :elixir_expand.mapfold/5
    (elixir 1.14.2) src/elixir_expand.erl:596: :elixir_expand.expand_args/3
    (elixir 1.14.2) src/elixir_expand.erl:421: :elixir_expand.expand/3
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:519: :elixir_expand.expand_list/5
    (elixir 1.14.2) src/elixir_expand.erl:429: :elixir_expand.expand/3
iex(6)> quote do:                      
...(6)> ( quote do
...(6)> 
...(6)>     IO.puts "aa" ; IO.puts "bb"
...(6)> end )
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(7)> 
"""

####

IO.puts """
Erlang/OTP 25 [erts-13.1.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.14.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> quote do IO.puts "aa" ; IO.puts "bb" ; end
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(2)> quote do quote do IO.puts "aa" ; IO.puts "bb" ; end ; end
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(3)> quote do IO.puts "aa" ; IO.puts "bb" end                 
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(4)> quote do quote do IO.puts "aa" ; IO.puts "bb" end end      
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(5)> quote do: quote do IO.puts "aa" ; IO.puts "bb" end   
** (CompileError) iex:5: undefined function quote/0 (there is no such import)
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:603: :elixir_expand.mapfold/5
    (elixir 1.14.2) src/elixir_expand.erl:596: :elixir_expand.expand_args/3
    (elixir 1.14.2) src/elixir_expand.erl:421: :elixir_expand.expand/3
    (elixir 1.14.2) src/elixir_expand.erl:587: :elixir_expand.expand_arg/3
    (elixir 1.14.2) src/elixir_expand.erl:519: :elixir_expand.expand_list/5
    (elixir 1.14.2) src/elixir_expand.erl:429: :elixir_expand.expand/3
iex(5)> quote do: (quote do IO.puts "aa" ; IO.puts "bb" end)
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(6)> quote do: (quote do IO.puts "aa" ; end)             
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(7)> quote do: (quote do IO.puts "aa" end)  
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(8)> quote do: (quote do: IO.puts "aa")   
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(9)> quote do quote do: IO.puts "aa" end  
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(10)> quote do quote do: IO.puts "aa" ;end
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(11)> quote do quote do: (IO.puts "aa" ; IO.puts "bb") end 
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(12)> quote do quote do: (IO.puts "aa" ; IO.puts "bb") ; end
{:quote, [context: Elixir],
 [
   [
     do: {:__block__, [],
      [
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
        {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
      ]}
   ]
 ]}
iex(13)> quote do quote do: (IO.puts "aa" ; IO.puts "bb") ;; end
** (SyntaxError) iex:13:51: unexpected token: ";" (column 51, code point U+003B)
    |
 13 | quote do quote do: (IO.puts "aa" ; IO.puts "bb") ;; end
    |                                                   ^
    (iex 1.14.2) lib/iex/evaluator.ex:292: IEx.Evaluator.parse_eval_inspect/3
    (iex 1.14.2) lib/iex/evaluator.ex:187: IEx.Evaluator.loop/1
    (iex 1.14.2) lib/iex/evaluator.ex:32: IEx.Evaluator.init/4
    (stdlib 4.1.1) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
iex(13)> quote do quote do: (IO.puts "aa" ; IO.puts "bb") ; ; end
** (SyntaxError) iex:13:52: unexpected token: ";" (column 52, code point U+003B)
    |
 13 | quote do quote do: (IO.puts "aa" ; IO.puts "bb") ; ; end
    |                                                    ^
    (iex 1.14.2) lib/iex/evaluator.ex:292: IEx.Evaluator.parse_eval_inspect/3
    (iex 1.14.2) lib/iex/evaluator.ex:187: IEx.Evaluator.loop/1
    (iex 1.14.2) lib/iex/evaluator.ex:32: IEx.Evaluator.init/4
    (stdlib 4.1.1) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
iex(13)> quote do: (quote do IO.puts "aa" ; end) ;                
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(14)> quote do: (quote do: (IO.puts "aa";) ;) ;
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(15)> (quote do: (quote do: (IO.puts "aa";) ;) ;) 
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(16)> (quote do: (quote do: (IO.puts "aa";) ;) ;) ;
{:quote, [context: Elixir],
 [[do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}]]}
iex(17)> quote do: (quote do: (IO.puts "aa";) ;) ; ;  
** (SyntaxError) iex:17:43: unexpected token: ";" (column 43, code point U+003B)
    |
 17 | quote do: (quote do: (IO.puts "aa";) ;) ; ;
    |                                           ^
    (iex 1.14.2) lib/iex/evaluator.ex:292: IEx.Evaluator.parse_eval_inspect/3
    (iex 1.14.2) lib/iex/evaluator.ex:187: IEx.Evaluator.loop/1
    (iex 1.14.2) lib/iex/evaluator.ex:32: IEx.Evaluator.init/4
    (stdlib 4.1.1) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
iex(17)> 
"""
