[link]: https://github.com/nushell/nushell/issues/7550#issuecomment-1365713754

link: [Some strange behave around `save`, `def` and `each` . · Issue #7550 · nushell/nushell][link]

--------

For this define:

~~~ sh
def save-new [p: string] {
    
    if ( 
        
        $p | path exists ) { 
        
        $in | null } else { 
        
        $in | save $p ; 
        
        (ls $p).name.0 | 
            path expand | 
            path relative-to ('../../..' | path expand) ; 
        
        } ; 
    
    } ;
~~~

And new version (`0.73.0`) environment: 

~~~ text
〉version 
╭────────────────────┬──────────────────────────────────────────╮
│ version            │ 0.73.0                                   │
│ branch             │ fix_wix_save                             │
│ commit_hash        │ cbb812bda6e249c8a106428039501a0157c5a1ea │
│ build_os           │ windows-x86_64                           │
│ build_target       │ x86_64-pc-windows-msvc                   │
│ rust_version       │ rustc 1.65.0 (897e37553 2022-11-02)      │
│ rust_channel       │ 1.65.0-x86_64-pc-windows-msvc            │
│ cargo_version      │ cargo 1.65.0 (4bc8f24d3 2022-10-20)      │
│ pkg_version        │ 0.73.0                                   │
│ build_time         │ 2022-12-21 07:39:03 -06:00               │
│ build_rust_channel │ release                                  │
│ features           │ database, default, trash, which, zip     │
│ installed_plugins  │                                          │
╰────────────────────┴──────────────────────────────────────────╯
~~~

*(path style will be change to *nix style .)*

#### Test 01

This ***Each test*** could work:

~~~ sh
mkdir aa bb cc ; ls | where type == dir | each {|d| '%%%' | save-new $"($d.name)/foo" }
~~~

<details>

<summary>out</summary>

~~~ text
path/to/test/e〉def save-new [p: string] { 
:::     
:::     if ( 
:::     
:::         $p | path exists ) { 
:::     
:::         $in | null } else { 
:::     
:::         $in | save $p ; 
:::     
:::         (ls $p).name.0 | 
:::             path expand | 
:::             path relative-to ('../../..' | path expand) ; 
:::         
:::         } ; 
:::     
:::     } ; 
path/to/test/e〉mkdir aa bb cc ; ls | where type == dir | each {|d| '%%%' | save-new $"($d.name)/foo" } 
╭───┬──────────────────╮
│ 0 │ to/test/e/aa/foo │
│ 1 │ to/test/e/bb/foo │
│ 2 │ to/test/e/cc/foo │
╰───┴──────────────────╯
path/to/test/e〉ls | 
::: each {|d| ls ($d.name) } | flatten | 
::: each {|d| ls ($d.name) } | flatten ; 
╭───┬────────┬──────┬──────┬──────────╮
│ # │  name  │ type │ size │ modified │
├───┼────────┼──────┼──────┼──────────┤
│ 0 │ aa/foo │ file │  3 B │ now      │
│ 1 │ bb/foo │ file │  3 B │ now      │
│ 2 │ cc/foo │ file │  3 B │ now      │
╰───┴────────┴──────┴──────┴──────────╯
path/to/test/e〉
~~~

</details>

#### Test 02

For this test, I want to create dirs named `a` `b` `c` `d` `e` `f` ,
 and for **each** of them create `aa/foo` `bb/foo` `cc/foo` `dd/foo` but
 **not overwrite** if file exist. 

There is already these things: 

~~~~ text
test〉ls | 
::: each {|d| ls ($d.name) } | flatten | 
::: each {|d| ls ($d.name) } | flatten ; 
╭───┬──────────┬──────┬──────┬───────────────╮
│ # │   name   │ type │ size │   modified    │
├───┼──────────┼──────┼──────┼───────────────┤
│ 0 │ a/aa/foo │ file │  3 B │ 2 hours ago   │
│ 1 │ e/aa/foo │ file │  3 B │ 7 minutes ago │
│ 2 │ e/bb/foo │ file │  3 B │ 7 minutes ago │
│ 3 │ e/cc/foo │ file │  3 B │ 7 minutes ago │
│ 4 │ x        │ file │  1 B │ an hour ago   │
│ 5 │ xx       │ file │  1 B │ an hour ago   │
╰───┴──────────┴──────┴──────┴───────────────╯
~~~~

Run this test here: 

~~~ sh
mkdir a b c d e f ; ls | where type == dir | 
    each { |d| 
        
        cd $d.name ; mkdir aa bb cc dd ; 
        ls | where type == dir | 
            each { |dd| 
                '@@@@@@@@@@' | save-new $"($dd.name)/foo" ; } ; 
        
        } | flatten ; 
~~~

but get Error: `nu::shell::eval_block_with_input` ([link][err-eval-block-with-input])

[err-eval-block-with-input]: https://docs.rs/nu-protocol/0.73.0/nu_protocol/enum.ShellError.html#variant.EvalBlockWithInput

<details>

<summary>err out</summary>

~~~~ text
path/to/test〉mkdir a b c d e f ; ls | where type == dir | 
:::     each { |d| 
:::         
:::         cd $d.name ; mkdir aa bb cc dd ; 
:::         ls | where type == dir | 
:::             each { |dd| 
:::                 '@@@@@@@@@@' | save-new $"($dd.name)/foo" ; } ; 
:::         
:::         } | flatten ; 
Error: nu::shell::eval_block_with_input (link)

  × Eval block failed with pipeline input
   ╭─[entry #62:4:1]
 4 │         cd $d.name ; mkdir aa bb cc dd ;
 5 │         ls | where type == dir |
   ·         ─┬
   ·          ╰── source value
 6 │             each { |dd|
   ╰────

Error:
  × Permission denied
    ╭─[entry #41:8:1]
  8 │
  9 │         $in | save $p ;
    ·                    ─┬
    ·                     ╰── 系统找不到指定的路径。 (os error 3)
 10 │
    ╰────


path/to/test〉ls | 
::: each {|d| ls ($d.name) } | flatten | 
::: each {|d| ls ($d.name) } | flatten ; 
╭───┬──────────┬──────┬──────┬────────────────╮
│ # │   name   │ type │ size │    modified    │
├───┼──────────┼──────┼──────┼────────────────┤
│ 0 │ a/aa/foo │ file │  3 B │ 2 hours ago    │
│ 1 │ e/aa/foo │ file │  3 B │ 37 minutes ago │
│ 2 │ e/bb/foo │ file │  3 B │ 37 minutes ago │
│ 3 │ e/cc/foo │ file │  3 B │ 37 minutes ago │
│ 4 │ x        │ file │  1 B │ 2 hours ago    │
│ 5 │ xx       │ file │  1 B │ 2 hours ago    │
╰───┴──────────┴──────┴──────┴────────────────╯
path/to/test〉
~~~~

</details>

Nothing be written.

**And**, when I change `save-new` to `save` : 

~~~ sh
mkdir a b c d e f ; ls | where type == dir | 
    each { |d| 
        
        cd $d.name ; mkdir aa bb cc dd ; 
        ls | where type == dir | 
            each { |dd| 
                '@@@@@@@@@@' | save $"($dd.name)/foo" ; } ; 
        
        } | flatten ; 
~~~

Error also in same `link` and **different** describe : 

<details>

<summary>err out <code>save</code></summary>

~~~~ text
path/to/test〉mkdir a b c d e f ; ls | where type == dir | 
:::     each { |d| 
:::     
:::         cd $d.name ; mkdir aa bb cc dd ; 
:::         ls | where type == dir | 
:::             each { |dd| 
:::                 '@@@@@@@@@@' | save $"($dd.name)/foo" ; } ; 
:::         
:::         } | flatten ; 
Error: nu::shell::eval_block_with_input (link)

  × Eval block failed with pipeline input
   ╭─[entry #63:4:1]
 4 │         cd $d.name ; mkdir aa bb cc dd ;
 5 │         ls | where type == dir |
   ·         ─┬
   ·          ╰── source value
 6 │             each { |dd|
   ╰────

Error:
  × Permission denied
   ╭─[entry #63:6:1]
 6 │             each { |dd|
 7 │                 '@@@@@@@@@@' | save $"($dd.name)/foo" ; } ;
   ·                                     ────────┬────────
   ·                                             ╰── 系统找不到指定的路径。 (os error 3)
 8 │
   ╰────


path/to/test〉ls |
::: each {|d| ls ($d.name) } | flatten | 
::: each {|d| ls ($d.name) } | flatten ; 
╭───┬──────────┬──────┬──────┬────────────────╮
│ # │   name   │ type │ size │    modified    │
├───┼──────────┼──────┼──────┼────────────────┤
│ 0 │ a/aa/foo │ file │  3 B │ 2 hours ago    │
│ 1 │ e/aa/foo │ file │  3 B │ 42 minutes ago │
│ 2 │ e/bb/foo │ file │  3 B │ 42 minutes ago │
│ 3 │ e/cc/foo │ file │  3 B │ 42 minutes ago │
│ 4 │ x        │ file │  1 B │ 2 hours ago    │
│ 5 │ xx       │ file │  1 B │ 2 hours ago    │
╰───┴──────────┴──────┴──────┴────────────────╯
path/to/test〉
~~~~

</details>

Says 'os cannot find the path' mean.

#### Test 03

**But** what will happen if I change `... | save $"($dd.name)/foo"` to `cd $dd.name ; ... | save foo` ?

Existing files will be overwrite if it works ... so I use `save-new` first : 

~~~ sh
mkdir a b c d e f ; ls | where type == dir | 
    each { |d| 
        
        cd $d.name ; mkdir aa bb cc dd ; 
        ls | where type == dir | 
            each { |dd| 
                
                cd $dd.name ; 
                '@@@@@@@@@@' | save-new foo ; } ; 
        
        } | flatten ; 
~~~

<details>

<summary>err out</summary>

~~~~ text
path/to/test〉mkdir a b c d e f ; ls | where type == dir | 
:::     each { |d| 
:::         
:::         cd $d.name ; mkdir aa bb cc dd ; 
:::         ls | where type == dir | 
:::             each { |dd| 
:::                 
:::                 cd $dd.name ; 
:::                 '@@@@@@@@@@' | save-new foo ; } ; 
:::         
:::         } | flatten ; 
Error: nu::shell::eval_block_with_input (link)

  × Eval block failed with pipeline input
   ╭─[entry #71:4:1]
 4 │         cd $d.name ; mkdir aa bb cc dd ;
 5 │         ls | where type == dir |
   ·         ─┬
   ·          ╰── source value
 6 │             each { |dd|
   ╰────

Error:
  × Destination file already exists
    ╭─[entry #41:8:1]
  8 │
  9 │         $in | save $p ;
    ·                    ─┬
    ·                     ╰── Destination file 'foo' already exists
 10 │
    ╰────
  help: you can use -f, --force to force overwriting the destination


path/to/test〉
~~~~

</details>

But take a look, when I run: 

~~~ sh
ls | 
 each {|d| ls ($d.name) } | flatten | 
 each {|d| ls ($d.name) } | flatten ; 
~~~

I get: 

~~~~ text
╭───┬──────────┬──────┬──────┬───────────────╮
│ # │   name   │ type │ size │   modified    │
├───┼──────────┼──────┼──────┼───────────────┤
│ 0 │ a/aa/foo │ file │  3 B │ 3 hours ago   │
│ 1 │ e/aa/foo │ file │  3 B │ 2 hours ago   │
│ 2 │ e/bb/foo │ file │  3 B │ 2 hours ago   │
│ 3 │ e/cc/foo │ file │  3 B │ 2 hours ago   │
│ 4 │ foo      │ file │ 10 B │ 2 minutes ago │
│ 5 │ x        │ file │  1 B │ 2 hours ago   │
│ 6 │ xx       │ file │  1 B │ 2 hours ago   │
╰───┴──────────┴──────┴──────┴───────────────╯
〉open foo
@@@@@@@@@@
~~~~

Here, line-num `4`, a `10 B` size file be created,
 and the content is I've saved at this test !

So, did my test code have some mistake ?

Let us change the content and change `save-new` to `save` : 

~~~ sh
mkdir a b c d e f ; ls | where type == dir | 
    each { |d| 
        
        cd $d.name ; mkdir aa bb cc dd ; 
        ls | where type == dir | 
            each { |dd| 
                
                cd $dd.name ; 
                'zzzz&&&' | save foo ; } ; 
        
        } | flatten ; 
~~~

Got an err but this err is current : 

~~~~ text
path/to/test〉mkdir a b c d e f ; ls | where type == dir | 
:::     each { |d| 
:::         
:::         cd $d.name ; mkdir aa bb cc dd ; 
:::         ls | where type == dir | 
:::             each { |dd| 
:::                 
:::                 cd $dd.name ; 
:::                 'zzzz&&&' | save foo ; } ; 
:::         
:::         } | flatten ; 
Error: nu::shell::eval_block_with_input (link)

  × Eval block failed with pipeline input
   ╭─[entry #77:4:1]
 4 │         cd $d.name ; mkdir aa bb cc dd ;
 5 │         ls | where type == dir |
   ·         ─┬
   ·          ╰── source value
 6 │             each { |dd|
   ╰────

Error:
  × Destination file already exists
    ╭─[entry #77:8:1]
  8 │                 cd $dd.name ;
  9 │                 'zzzz&&&' | save foo ; } ;
    ·                                  ─┬─
    ·                                   ╰── Destination file '.../path/to/test/a/aa/foo' already exists
 10 │
    ╰────
  help: you can use -f, --force to force overwriting the destination


path/to/test〉
~~~~

But the `7 Byte` size contents was be written : 

~~~ text
〉ls | 
::: each {|d| ls ($d.name) } | flatten | 
::: each {|d| ls ($d.name) } | flatten ; 
╭────┬──────────┬──────┬──────┬────────────────╮
│  # │   name   │ type │ size │    modified    │
├────┼──────────┼──────┼──────┼────────────────┤
│  0 │ a/aa/foo │ file │  3 B │ 3 hours ago    │
│  1 │ a/bb/foo │ file │  7 B │ 6 minutes ago  │
│  2 │ a/cc/foo │ file │  7 B │ 6 minutes ago  │
│  3 │ a/dd/foo │ file │  7 B │ 6 minutes ago  │
│  4 │ b/aa/foo │ file │  7 B │ 6 minutes ago  │
│  5 │ b/bb/foo │ file │  7 B │ 6 minutes ago  │
│  6 │ b/cc/foo │ file │  7 B │ 6 minutes ago  │
│  7 │ b/dd/foo │ file │  7 B │ 6 minutes ago  │
│  8 │ c/aa/foo │ file │  7 B │ 6 minutes ago  │
│  9 │ c/bb/foo │ file │  7 B │ 6 minutes ago  │
│ 10 │ c/cc/foo │ file │  7 B │ 6 minutes ago  │
│ 11 │ c/dd/foo │ file │  7 B │ 6 minutes ago  │
│ 12 │ d/aa/foo │ file │  7 B │ 6 minutes ago  │
│ 13 │ d/bb/foo │ file │  7 B │ 6 minutes ago  │
│ 14 │ d/cc/foo │ file │  7 B │ 6 minutes ago  │
│ 15 │ d/dd/foo │ file │  7 B │ 6 minutes ago  │
│ 16 │ e/aa/foo │ file │  3 B │ 2 hours ago    │
│ 17 │ e/bb/foo │ file │  3 B │ 2 hours ago    │
│ 18 │ e/cc/foo │ file │  3 B │ 2 hours ago    │
│ 19 │ e/dd/foo │ file │  7 B │ 6 minutes ago  │
│ 20 │ f/aa/foo │ file │  7 B │ 6 minutes ago  │
│ 21 │ f/bb/foo │ file │  7 B │ 6 minutes ago  │
│ 22 │ f/cc/foo │ file │  7 B │ 6 minutes ago  │
│ 23 │ f/dd/foo │ file │  7 B │ 6 minutes ago  │
│ 24 │ foo      │ file │ 10 B │ 16 minutes ago │
│ 25 │ x        │ file │  1 B │ 3 hours ago    │
│ 26 │ xx       │ file │  1 B │ 3 hours ago    │
├────┼──────────┼──────┼──────┼────────────────┤
│  # │   name   │ type │ size │    modified    │
╰────┴──────────┴──────┴──────┴────────────────╯
〉open f\cc\foo 
zzzz&&&
〉
~~~

So, the aim in ***Test 02*** has been done ... 😀

<!-- *(In my impression, on old version `0.72.1` the `save` will overwrite file in default ... So, thanks for the capability grow for `save` .)* -->

*just unperfect: **the strange behave** still exist. 😑*

