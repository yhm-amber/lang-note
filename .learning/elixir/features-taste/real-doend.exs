## all same these:
## 

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
quote do

    IO.puts "aa" ; IO.puts "bb"
end

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
