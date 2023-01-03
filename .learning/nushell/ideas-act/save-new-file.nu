
def save-new [path: string] { if ($p | path exists) { $in | null } else { $in | save ($path | path expand) ; (ls $p).name.0 | path expand | path relative-to ('../../..' | path expand) ; } ; } ;


def save-new [path: string] { 
    
    if ($path | path exists) { 
        
        $in | null ; } else { 
        
        $in | save ($path | path expand) ; 
        (ls $path).name.0 | 
            path expand | 
            path relative-to ('../../..' | path expand) ; 
        } ; 
    
    } ;


### 我可以假设 所有的目录都没有相关性
### 然后就可以有一个过滤 然后对剩下的目录做一个无分支的行为
### 
### 但这个假设是傲慢的 所以我宁愿对每个目录都做一个统一的
### 在不同情况时会有不同行为的 行为
### 
### 这个行为本身也可以成为一个 独立的工具
### 所以这样更赚 。
### 

# use:

mkdir a b c d e f ; ls | where type == dir | 
    each { |d| 
        
        cd $d.name ; mkdir aa bb cc dd ; 
        ls | where type == dir | 
            each { |dd| 
                
                cd $dd.name ; 
                '::::::::::::' | save-new filefoo ; } ; 
        
        } | flatten ; 

# look:

ls | 
 each {|d| ls ($d.name) } | flatten | 
 each {|d| ls ($d.name) } | flatten ; 

# better define:

def str-repeat [ 
    
    str: string 
    --repeat (-n): int = 1 
    --join (-j): string = ''] { 
    
    0..($repeat) |
        where {|x| $x > 0} | 
        each { $str } | 
        str join $join ; 
    
    } ; 

alias get-separator = (
    
    '~' | path expand | 
        str replace ('~' | path expand | path dirname) '' -sa | 
        str replace ('~' | path expand | path basename) '' -sa ) ; 

def show-prepath [ 
    
    path: string 
    --prepath (-r): int = 3 ] { 
    
    let sp = (get-separator) ; 
    
    (ls ($path | path expand) ).name | 
        path relative-to ( 
            [ 
                ( $path | path dirname ) , 
                ( str-repeat '..' -n $prepath --join $sp ) , 
            ] | 
                str join $sp | 
                path expand ) ; 
    
    } ; 

def save-new [path: string] { 
    
    if ($path | path exists) { 
        
        $in | null ; } else { 
        
        $in | save ($path | path expand) ; 
        (show-prepath $path -r 3).0 } ; 
    
    } ; 

