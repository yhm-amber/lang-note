def save-new [p: string] { if ($p | path exists) {$in | null} else { $in | save $p ; (ls $p).name.0 | path expand | path relative-to ('../../..' | path expand) } } ;

"######" | save-new foo ## will get file foo if not exist

mkdir aa bb cc ; ls | where type == dir | each {|d| cd ($d.name) ; '%%%' | save-new foo } ## will err
mkdir aa bb cc ; ls | where type == dir | each {|d| cd ($d.name) ; '%%%' | save foo } ## ... but this will NOT, WHY?

