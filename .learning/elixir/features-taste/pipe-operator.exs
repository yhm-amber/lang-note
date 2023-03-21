需要先理解 quote 。

"""
Erlang/OTP 25 [erts-13.1.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Interactive Elixir (1.14.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> ...
...
...
iex(19)> a = quote do: (IO.puts "aa" ; IO.puts "bb")             
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(20)> quote do: a 
{:a, [], Elixir}
iex(21)> quote do: unquote(a)
{:__block__, [],
 [
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}
 ]}
iex(22)> unquote(1)
** (CompileError) iex:22: unquote called outside quote
    (elixir 1.14.2) src/elixir.erl:376: :elixir.quoted_to_erl/4
    (elixir 1.14.2) src/elixir.erl:277: :elixir.eval_forms/4
    (elixir 1.14.2) lib/module/parallel_checker.ex:107: Module.ParallelChecker.verify/1
    (iex 1.14.2) lib/iex/evaluator.ex:329: IEx.Evaluator.eval_and_inspect/3
    (iex 1.14.2) lib/iex/evaluator.ex:303: IEx.Evaluator.eval_and_inspect_parsed/3
    (iex 1.14.2) lib/iex/evaluator.ex:292: IEx.Evaluator.parse_eval_inspect/3
    (iex 1.14.2) lib/iex/evaluator.ex:187: IEx.Evaluator.loop/1
iex(22)> Macro.to_string a   
"IO.puts(\"aa\")\nIO.puts(\"bb\")"
iex(23)> Macro.to_string a |> IO.puts
** (Protocol.UndefinedError) protocol String.Chars not implemented for {:__block__, [], [{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}, {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}]} of type Tuple
    (elixir 1.14.2) lib/string/chars.ex:3: String.Chars.impl_for!/1
    (elixir 1.14.2) lib/string/chars.ex:22: String.Chars.to_string/1
    (elixir 1.14.2) lib/io.ex:767: IO.puts/2
    iex:23: (file)
iex(23)> IO.puts( Macro.to_string a )
IO.puts("aa")
IO.puts("bb")
:ok
iex(24)> Macro.to_string a |> IO.puts()
** (Protocol.UndefinedError) protocol String.Chars not implemented for {:__block__, [], [{{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["aa"]}, {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [], ["bb"]}]} of type Tuple
    (elixir 1.14.2) lib/string/chars.ex:3: String.Chars.impl_for!/1
    (elixir 1.14.2) lib/string/chars.ex:22: String.Chars.to_string/1
    (elixir 1.14.2) lib/io.ex:767: IO.puts/2
    iex:24: (file)
iex(24)> a |> Macro.to_string |> IO.puts
IO.puts("aa")
IO.puts("bb")
:ok
iex(25)> quote do: (a |> Macro.to_string |> IO.puts)
{:|>, [context: Elixir, imports: [{2, Kernel}]],
 [
   {:|>, [context: Elixir, imports: [{2, Kernel}]],
    [
      {:a, [], Elixir},
      {{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]},
       [no_parens: true], []}
    ]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [no_parens: true],
    []}
 ]}
iex(26)> quote do: (a |> Macro.to_string)           
{:|>, [context: Elixir, imports: [{2, Kernel}]],
 [
   {:a, [], Elixir},
   {{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]},
    [no_parens: true], []}
 ]}
iex(27)> quote do: (Macro.to_string a)     
{{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]}, [],
 [{:a, [], Elixir}]}
iex(28)> quote do: (Macro.to_string a |> IO.puts)
{{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]}, [],
 [
   {:|>, [context: Elixir, imports: [{2, Kernel}]],
    [
      {:a, [], Elixir},
      {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]},
       [no_parens: true], []}
    ]}
 ]}
iex(29)> quote do: ((Macro.to_string a) |> IO.puts)
{:|>, [context: Elixir, imports: [{2, Kernel}]],
 [
   {{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]}, [],
    [{:a, [], Elixir}]},
   {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]}, [no_parens: true],
    []}
 ]}
iex(30)> quote do: (Macro.to_string (a |> IO.puts))
{{:., [], [{:__aliases__, [alias: false], [:Macro]}, :to_string]}, [],
 [
   {:|>, [context: Elixir, imports: [{2, Kernel}]],
    [
      {:a, [], Elixir},
      {{:., [], [{:__aliases__, [alias: false], [:IO]}, :puts]},
       [no_parens: true], []}
    ]}
 ]}
iex(31)> (Macro.to_string a) |> IO.puts()           
IO.puts("aa")
IO.puts("bb")
:ok
iex(32)> 
"""

"""
上面，一开始用 `Macro.to_string a |> IO.puts()` ，然而 `|>` 运算符优先级是更高的。
因此应该用 `(Macro.to_string a) |> IO.puts()` ，这样才能相当于 `a |> Macro.to_string |> IO.puts()` 。
"""
