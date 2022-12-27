
def save-new [p: string] { def msg [p: string] { (ls $p).name.0 | path expand | path relative-to ('../../..' | path expand) } ; if ($p | path exists) {$in | null} else  {$in | save $p ; msg $p} }


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



