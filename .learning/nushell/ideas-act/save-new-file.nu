
def save-new [path: string] { if ($p | path exists) { $in | null } else { $in | save ($path | path expand) ; (ls $p).name.0 | path expand | path relative-to ('../../..' | path expand) ; } ; } ;


def save-new [path: string] { 
    
    if ($p | path exists) { 
        
        $in | null ; } else { 
        
        $in | save ($path | path expand) ; 
        (ls $p).name.0 | 
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


